//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 2024/01/12.
//

import UIKit

final class NewContactViewController: UIViewController {
    var contactFileManager: ContactFileManager
    weak var delegate: UpdateNewContact? 
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    
    init?(coder: NSCoder, contactFileManager: ContactFileManager, delegate: UpdateNewContact?) {
        self.contactFileManager = contactFileManager
        self.delegate = delegate
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyboardType()
        phoneNumberTextField.delegate = self
    }
    
    @IBAction private func dismissButtonTapped(_ sender: UIButton) {
        showAlertWithConfirmation(message: "정말로 취소하시겠습니까?", isDestructive: true) { _ in
            self.dismiss(animated: true)
        }
    }
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text?.replacingOccurrences(of: " ", with: ""),
              let ageString = ageTextField.text,
              let phone = phoneNumberTextField.text,
              isInputValidated(name: name, age: ageString, phone: phone) else { return }
        
        guard let age = Int(ageString) else { return }
        contactFileManager.addContact(contact: Contact(name: name, age: age, phoneNumber: phone))
        showAlertWithConfirmation(message: "저장하시겠습니까?", isDestructive: false) { _ in
            self.delegate?.updateNewContact()
            self.dismiss(animated: true)
        }
    }
}

extension NewContactViewController {
    private func changeKeyboardType() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    private func isInputValidated(name: String, age: String, phone: String) -> Bool {
        return validateAndShowAlert(input: name, type: .name, error: .nameValidError) && validateAndShowAlert(input: age, type: .age, error: .ageValidError) && validateAndShowAlert(input: phone, type: .phoneNumber, error: .phoneNumberValidError)
    }
    
    private func validateAndShowAlert(input: String, type: RegularExpressionCheck, error: ValidError) -> Bool {
        guard RegularExpressionCheck.isValidString(string: input, forPattern: type) else {
            showAlert(message: error.localizedDescription)
            return false
        }
        return true
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let textStr = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        var text = textStr.replacingOccurrences(of: "-", with: "")
        
        let prefixValidationCheck = text.hasPrefix("02") || !text.hasPrefix("0")
        
        switch (prefixValidationCheck, text.count) {
        case (true, 3...5):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 2))
        case (true, 6...9):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 2))
            text.insert("-", at: text.index(text.endIndex, offsetBy: 6 - text.count))
        case (true, 10):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 2))
            text.insert("-", at: text.index(text.endIndex, offsetBy: 7 - text.count))
        case (false, 4...6):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 3))
        case (false, 7...10):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 3))
            text.insert("-", at: text.index(text.endIndex, offsetBy: 7 - text.count))
        case (false, 11):
            text.insert("-", at: text.index(text.startIndex, offsetBy: 3))
            text.insert("-", at: text.index(text.endIndex, offsetBy: 8 - text.count))
        default:
            break
        }
        textField.text = text
        return false
    }
}
