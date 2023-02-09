//
//  ContactTableViewCell.swift
//  ContactManagerUI
//
//  Created by 박재우 on 2023/01/31.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameAndAge: UILabel!
    @IBOutlet private weak var phoneNumber: UILabel!

    static var className: String {
        return String(describing: self)
    }
}

extension ContactTableViewCell {
    func configure(contact: Contact) {
        nameAndAge.text = "\(contact.name)(\(contact.age))"
        phoneNumber.text = contact.phoneNumber
    }
}
