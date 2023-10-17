//
//  ContactCell.swift
//  ios-contact-manager-ui
//
//  Created by 동준 on 10/17/23.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    weak var contact: Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with contact: Contact) {
        self.nameLabel.text = contact.name
        self.ageLabel.text = "\(contact.age)  세"
        self.phoneNumberLabel.text = contact.phoneNumber
        self.contact = contact
    }
}
