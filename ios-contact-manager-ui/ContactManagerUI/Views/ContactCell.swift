//
//  ContactTableViewCell.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/10.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var content: cellFormat?
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var configuration = defaultContentConfiguration()
        configuration.text = content?.mainText
        configuration.textProperties.font = .preferredFont(forTextStyle: .headline)
        configuration.secondaryText = content?.subText
        configuration.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        contentConfiguration = configuration
    }
}


protocol cellFormat {
    var mainText: String { get }
    var subText: String { get }
}

extension UserInfo: cellFormat {
    var mainText: String {
        return "\(name)(\(age))"
    }
    var subText: String {
        return "\(phone)"
    }
}
