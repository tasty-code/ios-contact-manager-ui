//
//  CustomCell.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/5/24.
//

import UIKit

final class CustomCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            contactNameLabel.text = contact.nameAndAge
            contactPhoneNumberLabel.text = contact.phoneNumber
        }
    }
    
    let contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contactPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0.2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupStackView()
        accessoryType = .disclosureIndicator
    }
    
    func setupStackView() {
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(contactNameLabel)
        stackView.addArrangedSubview(contactPhoneNumberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setConstraint()
        super.updateConstraints()
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            contactNameLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}

