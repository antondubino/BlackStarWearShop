//
//  ImageFullScreenCell.swift
//  BlackStarWearShop
//
//  Created by Антон Дубино on 09.07.2021.
//

import UIKit
import Kingfisher

class ImageFullScreenCell: UICollectionViewCell {
    
    @IBOutlet weak var imageFullScreen: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initImage(item: Product, index: Int){
    let url = URL(string: GetUrl.shared.getImage() + item.productImages[index])
        imageFullScreen.kf.setImage(with: url)
}
}
