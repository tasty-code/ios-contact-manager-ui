//
//  ContactTableViewCell.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/09.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var ageLabel: UILabel!
    @IBOutlet weak private var phoneNumberLabel: UILabel!
    
    func setData(_ viewModel: ContactTableViewModel) {
        nameLabel.text = viewModel.name
        ageLabel.text = String(viewModel.age) + " 세"
        phoneNumberLabel.text = viewModel.phoneNumber
    }
}
