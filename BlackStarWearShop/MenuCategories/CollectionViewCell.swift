import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameCategory: UILabel!
    
    func initCell(item: Category){
        self.nameCategory.text = item.name
    }
}
