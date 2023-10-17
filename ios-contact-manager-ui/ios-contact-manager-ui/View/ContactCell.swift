//
//  ContactCell.swift
//  ios-contact-manager-ui
//
//  Created by BOMBSGIE on 2023/10/10.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet private weak var thumbnailImage: UIImageView!
    @IBOutlet private weak var personLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    
    private let imageName = ["person.fill", "paperplane.fill", "trash.fill", "graduationcap.fill"]
    
    override func awakeFromNib() {
        self.accessoryType = .disclosureIndicator
    }
    
    override func prepareForReuse() {
        thumbnailImage.image = nil
        personLabel.text = "NaN"
        ageLabel.text = "0"
        phoneNumberLabel.text = "NaN"
    }
    
    func configureCell(_ contact: Contact) {
        thumbnailImage.image = UIImage(systemName: imageName[contact.age % imageName.count])
        personLabel.text = "이름: \(contact.name)"
        ageLabel.text = "나이: \(contact.age)"
        phoneNumberLabel.text = "연락처: \(contact.phoneNumber)"
    }
}
