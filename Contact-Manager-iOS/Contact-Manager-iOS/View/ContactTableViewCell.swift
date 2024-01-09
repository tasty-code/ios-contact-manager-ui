//
//  ContactTableViewCell.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    //MARK: - Property
    static let reuseIdentifier = "ContactTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupContactCellUI()
    }
    
    
    //MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupContactCellUI()
    }

    
    //MARK: - Method
    private func setupContactCellUI() {
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        accessoryType = .disclosureIndicator
    }

    func configure(with contact: Contact) {
        textLabel?.text = "\(contact.name)(\(contact.age ?? "0"))"
        detailTextLabel?.text = contact.contactNumber
    }
}

