import UIKit

final class ContactTableViewCell: UITableViewCell, ContactCellConfigurable {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(item contact: Contact) {
        self.title.text = "\(contact.name)(\(contact.age))"
        self.subTitle.text = contact.phoneNumber
    }
}
