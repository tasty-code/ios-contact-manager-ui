//
//  ContactTableViewCell.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
  @IBOutlet private var nameAndAgeLabel: UILabel!
  @IBOutlet private var phoneLabel: UILabel!
  
  func configure(model: Contact) {
    nameAndAgeLabel.text = model.nameAndAge
    phoneLabel.text = model.phone
  }
}
