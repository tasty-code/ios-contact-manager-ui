import UIKit

final class ContactTableViewCell: UITableViewCell, ContactCellConfigurable {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ tableView: ContactListViewController, item contact: Contact) {
        self.titleLabel.text = "\(contact.name)(\(contact.age))"
        self.subTitleLabel.text = contact.phoneNumber
    }
}
