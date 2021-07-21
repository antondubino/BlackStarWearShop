import UIKit
import Kingfisher

class MainMenuCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    func initCell(item: Product) {
        let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
        imageView.kf.setImage(with: url)
        self.productLabel.text = item.name
       if imageView.image == nil {
           imageView.image = UIImage(named: "bsw")
       }
    }
}
