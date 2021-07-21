import UIKit
import Kingfisher

class CollectionViewCellProducts: UICollectionViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceLabelProduct: UILabel!
    @IBOutlet weak var nameLabelProduct: UILabel!
    @IBOutlet weak var colorLabelProduct: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var widthOfOldPriceView: NSLayoutConstraint!
    
    var index = Product()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if index.oldPrice == nil {
            widthOfOldPriceView.constant = 0
        } else {
            oldPriceLabel.attributedText = NSAttributedString(string: (index.oldPrice!.split(separator: ".")[0]) + " ₽", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
    }
    
    func initCollectionCell(item: Product){
        let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
        imageProduct.kf.setImage(with: url)
        priceLabelProduct.text = String(item.price.split(separator: ".")[0] + " ₽")
        colorLabelProduct.text = item.colorName
        nameLabelProduct.text = item.name
        imageProduct.layer.cornerRadius = 5
        if imageProduct.image == nil {
            imageProduct.image = UIImage(named: "bsw")
        }
        prepareForReuse()
    }
}
