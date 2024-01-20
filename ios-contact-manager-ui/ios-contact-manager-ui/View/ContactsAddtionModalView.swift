//
//  ContactsAddtionModalView.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

final class ContactsAddtionModalView: UIView {
    private weak var delegate: UITextFieldDelegate? {
        didSet { self.phoneNumberTextField.delegate = self.delegate }
    }
    
    private let modalStackView: UIStackView = {
        let modalStackView = UIStackView()
        modalStackView.axis = .vertical
        return modalStackView
    }()
    
    private let titleStackView: UIStackView = {
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        return titleStackView
    }()
    private let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(nil, action: #selector(ContactsAdditionModalViewController.dismissContactsAdditionModalView), for: .touchUpInside)
        return cancelButton
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "새 연락처"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(nil, action: #selector(ContactsAdditionModalViewController.handleSaveButtonTap), for: .touchUpInside)
        return saveButton
    }()
    
    private let contentsStackView: UIStackView = {
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        return contentsStackView
    }()

    private let nameStackView: UIStackView = {
        let nameStackView = UIStackView()
        nameStackView.axis = .horizontal
        return nameStackView
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.textAlignment = .center
        nameLabel.font = .preferredFont(forTextStyle: .body)
        return nameLabel
    }()
    private let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.keyboardType = .default
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    
    private let ageStackView: UIStackView = {
        let ageStackView = UIStackView()
        ageStackView.axis = .horizontal
        return ageStackView
    }()
    private let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.text = "나이"
        ageLabel.textAlignment = .center
        ageLabel.font = .preferredFont(forTextStyle: .body)
        return ageLabel
    }()
    private let ageTextField: UITextField = {
        let ageTextField = UITextField()
        ageTextField.keyboardType = .numberPad
        ageTextField.borderStyle = .roundedRect
        return ageTextField
    }()
    
    private let phoneNumberStackView: UIStackView = {
        let phoneNumberStackView = UIStackView()
        phoneNumberStackView.axis = .horizontal
        return phoneNumberStackView
    }()
    private let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "연락처"
        phoneNumberLabel.textAlignment = .center
        phoneNumberLabel.font = .preferredFont(forTextStyle: .body)
        return phoneNumberLabel
    }()
    private let phoneNumberTextField: UITextField = {
        let phoneNumberTextField = UITextField()
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.borderStyle = .roundedRect
        return phoneNumberTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupStackViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactsAddtionModalView {
    public func setDelegate(delegate: UITextFieldDelegate?) {
        self.delegate = delegate
    }
    
    public func getText(from textField: TextField) -> String? {
        switch textField {
        case .name:
            return nameTextField.text ?? nil
        case .age:
            return ageTextField.text ?? nil
        case .phoneNumber:
            return phoneNumberTextField.text ?? nil
        }
    }
    
    public func setText(_ string: String, to textField: TextField) {
        switch textField {
        case .name:
            nameTextField.text = string
        case .age:
            ageTextField.text = string
        case .phoneNumber:
            phoneNumberTextField.text = string
        }
    }
    
    public func getTitleLabel() -> UILabel {
        return titleLabel
    }
}

extension ContactsAddtionModalView {
    private func setupStackViews() {
        self.addSubview(modalStackView)
        
        modalStackView.addArrangedSubview(titleStackView)
        modalStackView.addArrangedSubview(contentsStackView)
        
        titleStackView.addArrangedSubview(cancelButton)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(saveButton)
        
        contentsStackView.addArrangedSubview(nameStackView)
        contentsStackView.addArrangedSubview(ageStackView)
        contentsStackView.addArrangedSubview(phoneNumberStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        ageStackView.addArrangedSubview(ageLabel)
        ageStackView.addArrangedSubview(ageTextField)
        
        phoneNumberStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextField)
    }
    
    private func setupConstraints() {
        setupModalStackViewConstraints()
        setupTitleStackViewConstraints()
        setupContentsStackViewConstraints()
        setupNameStackViewConstraints()
        setupAgeStackViewConstraints()
        setupPhoneNumberStackViewConstraints()
    }
    
    private func setupModalStackViewConstraints() {
        modalStackView.translatesAutoresizingMaskIntoConstraints = false
        modalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        modalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        modalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        modalStackView.spacing = 20
    }
    
    private func setupTitleStackViewConstraints() {
        titleLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
    }
    
    private func setupContentsStackViewConstraints() {
        contentsStackView.spacing = 8
    }
    
    private func setupNameStackViewConstraints() {
        nameStackView.spacing = 15
        nameLabel.widthAnchor.constraint(equalTo: phoneNumberLabel.widthAnchor).isActive = true
    }
    
    private func setupAgeStackViewConstraints() {
        ageStackView.spacing = 15
        ageLabel.widthAnchor.constraint(equalTo: phoneNumberLabel.widthAnchor).isActive = true
    }
    
    private func setupPhoneNumberStackViewConstraints() {
        phoneNumberStackView.spacing = 15
        phoneNumberLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
    }
}
