import UIKit
import Kingfisher


class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageCartCell: UIImageView!
  
        func initImage(item: Product, index: Int){
                let url = URL(string: GetUrl.shared.getImage() + item.productImages[index])
                    imageCartCell.kf.setImage(with: url)
    }
    
        func initImage2(item: Product, index: Int){
                let url = URL(string: GetUrl.shared.getImage() + item.mainImage)
                    imageCartCell.kf.setImage(with: url)
    }
}

