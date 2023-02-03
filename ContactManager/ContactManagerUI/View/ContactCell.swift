//
//  ContactCell.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/01.
//

import UIKit

final class ContactCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    // MARK: - Helpers
    func configure(with contact: Contact) {
        titleLabel.text = "\(contact.name)(\(contact.age))"
        subTitleLabel.text = contact.phoneNumber
    }
}
