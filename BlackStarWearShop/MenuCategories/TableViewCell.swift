import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var textLabelCell: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func initCell2(item: Subcategory){
        textLabelCell.text = item.name
    }
}
