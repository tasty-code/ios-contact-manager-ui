//
//  ContactTableViewCell.swift
//  ContactManager
//
//  Created by Janine on 2023/10/19.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    static let identifier = "contactTableCell"

    @IBOutlet private var nameLabel: UILabel?
    @IBOutlet private var ageLabel: UILabel?
    @IBOutlet private var phoneNumLabel: UILabel?
    
    @IBOutlet private var nameContent: UILabel?
    @IBOutlet private var ageContent: UILabel?
    @IBOutlet private var phoneNumContent: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setAttributes()
    }
    
    private func setAttributes() {
        nameLabel?.text = ValidateType.name.description + " :"
        ageLabel?.text = ValidateType.age.description + " :"
        phoneNumLabel?.text = ValidateType.phoneNum.description + " :"
    }
    
    func configure(content: ContactInfo) {
        guard let name = content.name,
                let age = content.age,
                let phoneNum = content.phoneNum else { return }
        
        nameContent?.text = name
        ageContent?.text = String(age)
        phoneNumContent?.text = phoneNum
    }
}
