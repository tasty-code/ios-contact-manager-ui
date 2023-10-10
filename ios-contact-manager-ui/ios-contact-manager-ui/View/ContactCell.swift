//
//  ContactCell.swift
//  ios-contact-manager-ui
//
//  Created by BOMBSGIE on 2023/10/10.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var personLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    func configureCell(_ contact: Contact) {
        personLabel.text = "\(contact.name)(\(contact.age))"
        phoneNumberLabel.text = contact.phoneNumber
    }
    
}
