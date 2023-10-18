import UIKit

final class ContactTableViewCell: UITableViewCell, ContactCellConfigurable {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(item contact: Contact) {
        self.nameLabel.text = contact.name
        self.ageLabel.text = String(contact.age)
        self.phoneNumberLabel.text = contact.phoneNumber
    }
}
