//
//  ContactCellTableViewCell.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/18/24.
//

import UIKit

final class ContactsTableViewCell: UITableViewCell {
    static var className: String { String(describing: self) }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private let labelStackView: UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        return labelStackView
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름 :"
        nameLabel.textAlignment = .right
        nameLabel.font = .preferredFont(forTextStyle: .body)
        return nameLabel
    }()
    private let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.text = "나이 :"
        ageLabel.textAlignment = .right
        ageLabel.font = .preferredFont(forTextStyle: .body)

        return ageLabel
    }()
    private let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "연락처 :"
        phoneNumberLabel.textAlignment = .right
        phoneNumberLabel.font = .preferredFont(forTextStyle: .body)
        return phoneNumberLabel
    }()
    
    private let contactLabelStackView: UIStackView = {
        let contactLabelStackView = UIStackView()
        contactLabelStackView.axis = .vertical
        return contactLabelStackView
    }()
    private let contactNameLabel: UILabel = {
        let contactNameLabel = UILabel()
        contactNameLabel.textAlignment = .left
        contactNameLabel.font = .preferredFont(forTextStyle: .body)
        return contactNameLabel
    }()
    private let contactAgeLabel: UILabel = {
        let contactAgeLabel = UILabel()
        contactAgeLabel.textAlignment = .left
        contactAgeLabel.font = .preferredFont(forTextStyle: .body)
        return contactAgeLabel
    }()
    private let contactPhoneNumberLabel: UILabel = {
        let contactPhoneNumberLabel = UILabel()
        contactPhoneNumberLabel.textAlignment = .left
        contactPhoneNumberLabel.font = .preferredFont(forTextStyle: .body)
        return contactPhoneNumberLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStackView()
        setupStackViewConstraints()
        setupContentViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactsTableViewCell {
    public func setContactLabelText(contact: Contact) {
        contactNameLabel.text = contact.name
        contactAgeLabel.text = "\(contact.age) 세"
        contactPhoneNumberLabel.text = contact.phoneNumber
    }
}

extension ContactsTableViewCell {
    private func setupStackView() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(contactLabelStackView)
        setupLabelStackView()
        setupContactLabelStackView()
    }
    
    private func setupLabelStackView() {
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(ageLabel)
        labelStackView.addArrangedSubview(phoneNumberLabel)
    }
    
    private func setupContactLabelStackView() {
        contactLabelStackView.addArrangedSubview(contactNameLabel)
        contactLabelStackView.addArrangedSubview(contactAgeLabel)
        contactLabelStackView.addArrangedSubview(contactPhoneNumberLabel)
    }
    
    private func setupContentViewConstraints() {
        contentView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1.1).isActive = true
    }
    
    private func setupStackViewConstraints() {
        labelStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contactLabelStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
    }
}
