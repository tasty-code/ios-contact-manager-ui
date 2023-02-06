//
//  ContactTableViewCell.swift
//  ContactManagerUI
//
//  Created by 박재우 on 2023/01/31.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var nameAndAge: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!

    static var className: String {
        return String(describing: self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ContactTableViewCell {
    func configure(contact: Contact) {
        nameAndAge.text = "\(contact.name)(\(contact.age))"
        phoneNumber.text = contact.phoneNumber
    }
}
