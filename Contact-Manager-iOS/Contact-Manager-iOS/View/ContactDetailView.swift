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
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.label
        textField.tintColor = UIColor.label
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = UIKeyboardType.asciiCapable
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.label
        textField.tintColor = UIColor.label
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = UIKeyboardType.numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let contactNumberTextField: UITextField = {
        let textField = UITextField()
        textField.frame.size.height = 20
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor.label
        textField.tintColor = UIColor.label
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.spellCheckingType = UITextSpellCheckingType.no
        textField.clearsOnBeginEditing = false
        textField.keyboardType = UIKeyboardType.phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, contactNumberLabel])
        stackView.spacing = stackViewSpace
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ageTextField, contactNumberTextField])
        stackView.spacing = stackViewSpace
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, textFieldStackView])
        stackView.spacing = 10
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - Intitializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.systemBackground
        configureStackView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    private func configureStackView() {
        self.addSubview(allStackView)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    // MARK: - AutoLayout Setting
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
