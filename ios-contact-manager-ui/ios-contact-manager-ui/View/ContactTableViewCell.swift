//
//  ContactTableViewCell.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/4/24.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let stackView: UIStackView = {
        let sv: UIStackView = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
}

extension ContactTableViewCell {
    private func setupStackView() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
    }
}
