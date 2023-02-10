//
//  ContactCell.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/10.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var content: CellFormat?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var configuration = defaultContentConfiguration().updated(for: state)
        configuration.text = content?.mainText
        configuration.textProperties.font = .preferredFont(forTextStyle: .headline)
        configuration.secondaryText = content?.subText
        configuration.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        contentConfiguration = configuration
    }
}
