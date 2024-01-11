//
//  ContactListCell.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ContactListCell: UITableViewCell {
    private let infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [infoLabel, phoneNumberLabel])
        stack.axis = .vertical
        stack.spacing = 2
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(self.labelStack)
        NSLayoutConstraint.activate([
            self.labelStack.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.labelStack.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.labelStack.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.labelStack.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func update(with newContact: Contact) {
        let info = "\(newContact.name)(\(newContact.age))"
        self.infoLabel.text = info
        self.phoneNumberLabel.text = newContact.phoneNumber
    }
}

extension ContactListCell: ReusableCell { }
