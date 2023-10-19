//
//  ContactCell.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 10/18/23.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    func configureCell(_ contact: Contact) {
        thumbnailImage.image = UIImage(systemName: "person")
        nameLabel.text = contact.name.toNameText()
        ageLabel.text = "\(contact.age)".toAgeText()
        phoneNumberLabel.text = contact.phoneNumber.toPhoneNumberText()
    }
}
