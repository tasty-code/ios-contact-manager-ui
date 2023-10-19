import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    static let cellName = "CustomTableViewCell"
    static let customCellIdentifier = "customCell"

    func configure(with contact: ContactDTO) {
        name.text = "\(contact.name)"
        age.text = "\(contact.age)"
        phoneNumber.text = "\(contact.phoneNumber)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
