//
//  ContactTableViewCell.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var ageLabel: UILabel!
  @IBOutlet private var phoneLabel: UILabel!
  
  func configure(model: Contact) {
    nameLabel.text = model.name
    ageLabel.text = String(model.age)
    phoneLabel.text = model.phone
  }
}
