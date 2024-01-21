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
    var selectedContact: Contact?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    
    init?(coder: NSCoder, contactFileManager: ContactFileManager, delegate: UpdateNewContact?, selectedContact: Contact?) {
        self.contactFileManager = contactFileManager
        self.delegate = delegate
        self.selectedContact = selectedContact
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindContactData() {
        guard let selectedContact = selectedContact else { return }
        nameTextField.text = selectedContact.name
        ageTextField.text = "\(selectedContact.age)"
        phoneNumberTextField.text = selectedContact.phoneNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyboardType()
        phoneNumberTextField.delegate = self
        bindContactData()
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
        var text2 = textStr.replacingOccurrences(of: " ", with: "")
        text2 = text2.replacingOccurrences(of: "(", with: "")
        text2 = text2.replacingOccurrences(of: ")", with: "")
        text2 = text2.replacingOccurrences(of: "-", with: "")
        let prefixValidationCheck = text2.hasPrefix("02") || !text2.hasPrefix("0") && !text2.hasPrefix("+")
        
        if text2.hasPrefix("+8202") {
            switch text2.count {
            case 4...5:
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
            case 6...8:
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 6 - text2.count))
            case 9...12:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 9 - text2.count))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 13 - text2.count))
            case 13:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 9 - text2.count))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 14 - text2.count))
            case 14...:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
            default:
                break
            }
            
        } else if text2.hasPrefix("+820") {
            switch text2.count {
            case 4...6:
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
            case 7...9:
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 7 - text2.count))
            case 10...13:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 10 - text2.count))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 14 - text2.count))
            case 14:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 10 - text2.count))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 15 - text2.count))
            case 15...:
                text2.insert("(", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(")", at: text2.index(text2.startIndex, offsetBy: 5))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert(" ", at: text2.index(text2.startIndex, offsetBy: 7))
            default:
                break
            }
        } else if (prefixValidationCheck) {
            switch (prefixValidationCheck, text2.count) {
            case (true, 3...5):
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 2))
            case (true, 6...9):
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 2))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 6 - text2.count))
            case (true, 10):
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 2))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 7 - text2.count))
            default:
                break
            }
        } else {
            switch text2.count {
            case  4...6:
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 3))
            case 7...10:
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 7 - text2.count))
            case 11:
                text2.insert("-", at: text2.index(text2.startIndex, offsetBy: 3))
                text2.insert("-", at: text2.index(text2.endIndex, offsetBy: 8 - text2.count))
            default:
                break
            }
        }
        textField.text = text2
        return false
    }
}
