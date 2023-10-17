import UIKit

final class ContactTableViewCell: UITableViewCell, ContactCellConfigurable {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ tableView: ContactListViewController, item contact: Contact) {
        
    }
}
