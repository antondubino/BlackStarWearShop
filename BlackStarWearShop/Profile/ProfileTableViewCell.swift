import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func initCell(group: Group) {
        self.nameLabel.text = group.name
    }
}
