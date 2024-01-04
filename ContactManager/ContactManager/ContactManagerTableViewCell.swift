//
//  ContactManagerTableViewCell.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

class ContactManagerTableViewCell: UITableViewCell {
    
    static let identifier = "ContactManagerTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setUpData(data: ContactInfoModel) {
        titleLabel.text = "\(data.name)(\(data.age))"
        subtitleLabel.text = data.phoneNumber
    } 
}
