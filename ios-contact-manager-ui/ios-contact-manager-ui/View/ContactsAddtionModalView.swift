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
    
    let modalStackView: UIStackView = {
        let modalStackView = UIStackView()
        modalStackView.axis = .vertical
        return modalStackView
    }()
    
    let titleStackView: UIStackView = {
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        return titleStackView
    }()
    let cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(nil, action: #selector(ContactsAdditionModalViewController.dismissContactsAdditionModalView), for: .touchUpInside)
        return cancelButton
    }()
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "새 연락처"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(nil, action: #selector(ContactsAdditionModalViewController.handleSaveButtonTap), for: .touchUpInside)
        return saveButton
    }()
    
    let contentsStackView: UIStackView = {
        let contentsStackView = UIStackView()
        contentsStackView.axis = .vertical
        return contentsStackView
    }()

    let nameStackView: UIStackView = {
        let nameStackView = UIStackView()
        nameStackView.axis = .horizontal
        return nameStackView
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이름"
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.keyboardType = .default
        nameTextField.borderStyle = .roundedRect
        return nameTextField
    }()
    
    let ageStackView: UIStackView = {
        let ageStackView = UIStackView()
        ageStackView.axis = .horizontal
        return ageStackView
    }()
    let ageLabel: UILabel = {
        let ageLabel = UILabel()
        ageLabel.text = "나이"
        ageLabel.textAlignment = .center
        return ageLabel
    }()
    let ageTextField: UITextField = {
        let ageTextField = UITextField()
        ageTextField.keyboardType = .numberPad
        ageTextField.borderStyle = .roundedRect
        return ageTextField
    }()
    
    let phoneNumberStackView: UIStackView = {
        let phoneNumberStackView = UIStackView()
        phoneNumberStackView.axis = .horizontal
        return phoneNumberStackView
    }()
    let phoneNumberLabel: UILabel = {
        let phoneNumberLabel = UILabel()
        phoneNumberLabel.text = "연락처"
        phoneNumberLabel.textAlignment = .center
        return phoneNumberLabel
    }()
    let phoneNumberTextField: UITextField = {
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


