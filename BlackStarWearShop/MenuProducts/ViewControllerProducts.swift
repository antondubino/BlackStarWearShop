import UIKit

class ViewControllerProducts: UIViewController {

    var itemID = 0
    var products: [Product] = []
    var productIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCellProducts", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCellProducts")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func numberFormatter (_ numberString: String) -> String {
        let formatedString = NumberFormatter()
        formatedString.groupingSeparator = " "
        formatedString.numberStyle = .decimal
        return formatedString.string(from: NSNumber(value: Int(Double(numberString)!)))!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProductsLoader().loadProducts(id: itemID) { products in
            self.products = products
            self.collectionView.reloadData()
        }
    }
}

extension ViewControllerProducts: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellProducts", for: indexPath) as! CollectionViewCellProducts
        cell.index = products[indexPath.row]
        cell.initCollectionCell(item: products[indexPath.row])
        cell.imageProduct.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 2 - 40).isActive = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.productIndex = indexPath.row
        let vc = storyboard?.instantiateViewController(identifier: "CartController") as! CartViewController
        let productSelect = products[self.productIndex]
        vc.product = productSelect
        self.present(vc, animated: true, completion: nil)
    }
}
