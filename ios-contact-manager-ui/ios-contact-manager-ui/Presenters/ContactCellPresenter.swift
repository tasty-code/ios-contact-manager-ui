//
//  ContactCellPresenter.swift
//  ios-contact-manager-ui
//
//  Created by BOMBSGIE on 2023/10/19.
//

import UIKit

class ContactCellPresenter: CellPresenter {
    
    
    private(set) var cell: UITableViewCell?
    private let profileImages = [
        UIImage(systemName: "person"), UIImage(systemName: "paperplane.fill"), UIImage(systemName: "powersleep"),
        UIImage(systemName: "sun.min.fill"), UIImage(systemName: "drop.fill")
    ]
    
    func setCell(_ cell: UITableViewCell) {
        self.cell = cell
    }
    
    func formatContent(_ content: Contact) {
        let image = profileImages[Int.random(in: 0..<profileImages.count)]
        let name = content.name.toNameText()
        let age = "\(content.age)".toAgeText()
        let phoneNumber = content.phoneNumber.toPhoneNumberText()
        
        
        
        guard let contactCell = self.cell as? ContactCell else {
            return
        }
        contactCell.configureCell((image, name, age, phoneNumber))
    }
    
    
}
