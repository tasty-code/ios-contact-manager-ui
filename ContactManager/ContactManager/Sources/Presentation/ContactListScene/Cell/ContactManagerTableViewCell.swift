//
//  ContactManagerTableViewCell.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

class ContactManagerTableViewCell: UITableViewCell {
    
    // MARK: @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: Custom Methods
    func setUpData(data: ContactInfoModel) {
        titleLabel.text = "\(data.name)(\(data.age))"
        subtitleLabel.text = data.phoneNumber
    } 
}
