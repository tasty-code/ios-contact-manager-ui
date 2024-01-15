//
//  ContactDetailView.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/11/24.
//

import UIKit

final class ContactDetailView: UIView {

    // MARK: - Properties
    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            nameTextField.text = contact.name
            ageTextField.text = contact.age
            contactNumberTextField.text = contact.contactNumber
        }
    }
    
    private let stackViewSpace: CGFloat = 7
    
    private let labelWidth: CGFloat = 55
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = .clear
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = .alphabet
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = .clear
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contactNumberTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = .clear
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.black
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, contactNumberLabel])
        stackView.spacing = stackViewSpace
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ageTextField, contactNumberTextField])
        stackView.spacing = stackViewSpace
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, textFieldStackView])
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - Intitializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    private func configureUI() {
        self.addSubview(allStackView)
    }
    
    func accessNameTextField() -> UITextField {
        return nameTextField
    }
    
    func accessAgeTextField() -> UITextField {
        return ageTextField
    }
    
    func accessContactNumberTextField() -> UITextField {
        return contactNumberTextField
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    // MARK: - AutoLayout Setting
    override func updateConstraints() {
        configureConstraints()
        super.updateConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            contactNumberLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
        
        NSLayoutConstraint.activate([
            allStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            allStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant:20),
            allStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}
