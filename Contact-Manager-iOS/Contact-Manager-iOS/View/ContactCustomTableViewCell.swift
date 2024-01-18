//
//  ContactCustomTableViewCell.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/18/24.
//

import UIKit

final class ContactCustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            contactNameLabel.text = "이   름 : \(contact.name)"
            contactAgeLabel.text = "나   이 : \(contact.age ?? "나이 없음")"
            contactNumberLabel.text = "연락처 : \(contact.contactNumber ?? "연락처 없음")"
        }
    }
    
    private let contactNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactNameLabel, contactAgeLabel, contactNumberLabel])
        stackView.spacing = 5
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "PersonalContactTableViewCell")
        
        configureStackView()
        configureCellDetail()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    private func configureStackView() {
        self.addSubview(allStackView)
    }
    
    private func configureCellDetail() {
        accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }
    
    
    // MARK: - AutoLayout Setting
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            allStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            allStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
        ])
    }
}
