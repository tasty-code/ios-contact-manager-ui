//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/02/06.
//

import UIKit

protocol AddContactViewDelegate {
    func reloadTableView()
}

class AddContactViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: AddContactViewDelegate?
    
    private var newContactNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "새 연락처")
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButtonTapped))
        let saveItem = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: #selector(saveButtonTapped))
        navigationItem.leftBarButtonItem = cancelItem
        navigationItem.rightBarButtonItem = saveItem
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textAlignment = .center
        return label
    }()
    
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        label.textAlignment = .center
        return label
    }()
    
    private var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "연락처"
        label.textAlignment = .center
        return label
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
        
        textField.placeholder = "이름 입력"
        
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private var ageTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
        
        textField.placeholder = "나이 입력"
        
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0
        
        textField.placeholder = "전화번호 입력"
        
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 0.0))
        textField.leftViewMode = .always
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var ageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var phoneNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var contactInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        configureLayout()
        
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
        
        ageTextField.addDoneButtonToKeyboard(doneAction: #selector(moveToPhoneNumberTextField))
        phoneNumberTextField.addHyphenAndDoneButtonToKeyboard(doneAction: #selector(phoneNumberTextField.resignFirstResponder), hyphenAction: #selector(addHyphenPunctuation))
    }
    
    // MARK: - Functions(ViewLayout)
    
    private func addSubview() {
        view.addSubview(newContactNavigationBar)
        view.addSubview(contactInfoStackView)
        contactInfoStackView.addArrangedSubview(nameStackView)
        contactInfoStackView.addArrangedSubview(ageStackView)
        contactInfoStackView.addArrangedSubview(phoneNumberStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        ageStackView.addArrangedSubview(ageLabel)
        ageStackView.addArrangedSubview(ageTextField)
        
        phoneNumberStackView.addArrangedSubview(phoneNumberLabel)
        phoneNumberStackView.addArrangedSubview(phoneNumberTextField)
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        newContactNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newContactNavigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            newContactNavigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            newContactNavigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            newContactNavigationBar.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        contactInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactInfoStackView.topAnchor.constraint(equalTo: newContactNavigationBar.bottomAnchor, constant: 20),
            contactInfoStackView.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor, constant: 20),
            contactInfoStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
        ])
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalTo: contactInfoStackView.widthAnchor, multiplier: 0.8)
        ])
        
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageTextField.widthAnchor.constraint(equalTo: contactInfoStackView.widthAnchor, multiplier: 0.8)
        ])
        
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumberTextField.widthAnchor.constraint(equalTo: contactInfoStackView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    // MARK: - Functions(Button Tapped)
    
    @objc private func cancelButtonTapped() {
        self.view.endEditing(true)
        showCancelAlert()
    }
    
    @objc private func saveButtonTapped() {
        
        guard var inputName = nameTextField.text, let inputAge = ageTextField.text, let inputPhoneNumber = phoneNumberTextField.text else {
            return
        }
        
        inputName = inputName.components(separatedBy: [" "]).joined()
        
        guard validate(nameValue: inputName, ageValue: inputAge, phoneNumberValue: inputPhoneNumber) else { return }
        makeContact(with: inputName, with: inputAge, with: inputPhoneNumber)
        
        delegate?.reloadTableView()
        dismiss(animated: true)
    }
    
    private func validate(nameValue: String, ageValue: String, phoneNumberValue: String) -> Bool {
        let validationResultPair = ["이름" : hasNoNameError(name: nameValue), "나이" : hasNoAgeError(age: ageValue), "연락처" : hasNoPhoneNumberError(number: phoneNumberValue)]
        
        let errorCategories = Array(validationResultPair.filter { $0.value == false }.keys)
        
        if !errorCategories.isEmpty {
            let errorTitle = makeErrorTitle(from: errorCategories)
            showErrorAlert(with: errorTitle)
            return false
        }
        return true
    }
    
    private func makeContact(with name: String, with age: String, with phoneNumber: String) {
        guard let age = Int(age) else { return }
        let contact = Contact(name: name, age: String(age), phoneNumber: phoneNumber)
        contacts.append(contact)
    }
    
    private func showCancelAlert() {
        let alertTitle: String = "정말로 취소하시겠습니까?"
        let confirmActionTitle: String = "예"
        let cancelActionTitle: String = "아니오"

        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .default) { _ in
            self.nameTextField.becomeFirstResponder()
        }

        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }

    private func makeErrorTitle(from categories: [String]) -> String {
        var errorKeywords = ""
        for index in categories.indices {
            errorKeywords = errorKeywords + "," + categories[index]
        }
        errorKeywords.removeFirst()
        let errorTitle = "입력한 \(errorKeywords) 정보가 잘못되었습니다"
        return errorTitle
    }
    private func showErrorAlert(with errorTitle: String) {
        let confirmActionTitle: String = "확인"
        
        let alert = UIAlertController(title: errorTitle, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: confirmActionTitle, style: .default)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    // MARK: - Functions(ToolBar)
    
    @objc private func moveToPhoneNumberTextField() {
        ageTextField.resignFirstResponder()
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @objc private func addHyphenPunctuation() {
        guard let inputPhoneNumber = phoneNumberTextField.text else { return }
        phoneNumberTextField.text = inputPhoneNumber + "-"
    }
}

extension AddContactViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        }
        return true
    }
}
