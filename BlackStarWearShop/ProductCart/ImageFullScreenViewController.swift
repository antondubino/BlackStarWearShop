//
//  ImageFullScreenViewController.swift
//  BlackStarWearShop
//
//  Created by Антон Дубино on 09.07.2021.
//

import UIKit

class ImageFullScreenViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!

    
    var itemID = 0
    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension ImageFullScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageFullScreenViewCell", for: indexPath) as! ImageFullScreenCell
        cell.initImage(item: product, index: indexPath.row)
        return cell
    }
    
    
}
