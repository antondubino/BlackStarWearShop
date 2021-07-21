import UIKit

class CartViewController: UIViewController {

    var product = Product()
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel1: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var widthOfIldPrice: NSLayoutConstraint!
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "Size", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Size", let destination = segue.destination as? SizeViewController {
            let productSelect = product
        destination.product = productSelect
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addButton.setTitle("ДОБАВИТЬ В КОРЗИНУ", for: .normal)
        self.addButton.layer.cornerRadius = 8
        self.costLabel1.text = "Стоимость:"
        self.nameLabel.text = product.name
        self.descriptionTextView.text = product.description
        self.costLabel.text = String(product.price.split(separator: ".")[0] + " ₽")
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        if product.oldPrice == nil {
            self.widthOfIldPrice.constant = 0
        } else {
            self.oldPriceLabel.attributedText = NSAttributedString(string: (product.oldPrice!.split(separator: ".")[0]) + " ₽", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width
        let h = view.frame.height
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if product.productImages.count == 0 {
            pageControl.numberOfPages = 1
        return 1
        } else {
            pageControl.numberOfPages = product.productImages.count
        return product.productImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCartCell", for: indexPath) as! ImageCell
        if product.productImages.count == 0 {
            cell.initImage2(item: product, index: indexPath.row)
        } else {
            cell.initImage(item: product, index: indexPath.row)
        }
        return cell
    }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = imageCollectionView.contentOffset.x
        let width = imageCollectionView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}
