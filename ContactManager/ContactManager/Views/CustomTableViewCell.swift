import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var nameAge: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!

    static let cellName = "CustomTableViewCell"
    static let customCellIdentifier = "customCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with contact: ContactDTO) {
        nameAge.text = "\(contact.name) (\(contact.age))"
        phoneNumber.text = "\(contact.phoneNumber)"
    }
}
