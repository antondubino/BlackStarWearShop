import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func initCell(item: ProductData){
        let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
        self.productImageView.kf.setImage(with: url)
        nameLabel.text = item.name
        sizeLabel.text = "Размер: \(item.size)"
        colorLabel.text = "Цвет: \(item.colorName)"
        costLabel.text = "\(Int(Double(item.price) ?? 0)) ₽"
        countLabel.text = "\(item.count) шт"
        if productImageView.image == nil {
            productImageView.image = UIImage(named: "bsw")
        }
    }
}
