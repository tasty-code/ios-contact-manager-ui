import UIKit

final class ContactTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(item contact: Contact) {
        var content = self.defaultContentConfiguration()
        content.text = "\(contact.name)(\(contact.age))"
        content.secondaryText = "\(contact.phoneNumber)"
        self.contentConfiguration = content
    }
}
