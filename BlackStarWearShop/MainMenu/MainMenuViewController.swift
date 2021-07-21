import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [Product] = []
    let itemID = 74
    var productIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProductsLoader().loadProducts(id: itemID) { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCollectionViewCell", for: indexPath) as! MainMenuCollectionViewCell
        cell.initCell(item: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height * 0.8
     return CGSize(width: w, height: h)
 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productIndex = indexPath.row
        let vc = storyboard?.instantiateViewController(identifier: "CartController") as! CartViewController
        let productSelect = products[self.productIndex]
        vc.product = productSelect
        self.present(vc, animated: true, completion: nil)
    }
    
}
