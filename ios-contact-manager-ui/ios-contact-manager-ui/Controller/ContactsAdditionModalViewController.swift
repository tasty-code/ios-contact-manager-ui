//
//  ContactsAdditionModalViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

final class ContactsAdditionModalViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: ContactsManageable?
    private var regexByTextField: Dictionary<UITextField, String>
    private var invalidationByTextField: Dictionary<UITextField, InvalidationInput>
    private let contactsAdditionModalView: ContactsAddtionModalView
    private var sortedTextField: Array<UITextField>
    var reloadData: (() -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        regexByTextField = [:]
        invalidationByTextField = [:]
        sortedTextField = []
        contactsAdditionModalView = ContactsAddtionModalView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        contactsAdditionModalView.phoneNumberTextField.delegate = self
        setSortedTextField()
        setRegexByTextField()
        setInvalidationByTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contactsAdditionModalView
    }
}

extension ContactsAdditionModalViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }

        textField.text = string == "" ? deleteKeyTapped(text: text, range: range) : numberKeyTapped(text: text, range: range)
        return true
    }
    
    private func numberKeyTapped(text: String, range: NSRange) -> String {
        var resultText = text
        
        switch text.starts(with: "0") {
        case true:
            switch range.location {
            case 3, 7:
                resultText += "-"
                return resultText
            case 12:
                return exchange(string: text, of: 8, isDelete: false)
            default:
                return text
            }
        case false:
            switch range.location {
            case 2, 6:
                resultText += "-"
                return resultText
            case 11:
                return exchange(string: text, of: 7, isDelete: false)
            default:
                return text
            }
        }
    }
    
    private func deleteKeyTapped(text: String, range: NSRange) -> String {
        var resultText = text
        
        switch text.starts(with: "0") {
        case true:
            switch range.location {
            case 4, 8:
                resultText.popLast()
                return resultText
            case 12:
                return exchange(string: text, of: 7, isDelete: true)
            default:
                return text
            }
        case false:
            switch range.location {
            case 3, 7:
                resultText.popLast()
                return resultText
            case 11:
                return exchange(string: text, of: 6, isDelete: true)
            default:
                return text
            }
        }
    }
    
    private func exchange(string: String, of: Int, isDelete: Bool) -> String {
        var textArray: Array<Character> = Array(string)
        let characterToBeExchanged: Character = textArray[of]
        textArray[of] = "-"
        
        switch isDelete {
        case true:
            textArray[of + 1] = characterToBeExchanged
            textArray.popLast()
        case false:
            textArray[of - 1] = characterToBeExchanged
        }
        
        return String(textArray)
    }
}

extension ContactsAdditionModalViewController {
    private func setRegexByTextField() {
        regexByTextField = [
            contactsAdditionModalView.nameTextField: InvalidationInput.name.regex,
            contactsAdditionModalView.ageTextField: InvalidationInput.age.regex,
            contactsAdditionModalView.phoneNumberTextField: InvalidationInput.phoneNumber.regex
        ]
    }
    
    private func setInvalidationByTextField() {
        invalidationByTextField = [
            contactsAdditionModalView.nameTextField: .name,
            contactsAdditionModalView.ageTextField: .age,
            contactsAdditionModalView.phoneNumberTextField: .phoneNumber
        ]
    }
    
    private func setSortedTextField() {
        sortedTextField = [
            contactsAdditionModalView.nameTextField,
            contactsAdditionModalView.ageTextField,
            contactsAdditionModalView.phoneNumberTextField,
        ]
    }
}

extension ContactsAdditionModalViewController {
    @objc func dismissContactsAdditionModalView() {
        makeCancelAlert(message: "정말로 취소하시겠습니까?", destructiveAction: { _ in self.dismiss(animated: true) })
    }
    
    @objc func saveButtonDidTapped() {
        if let invalidationInput = validateTextFields() {
            makeAlert(message: invalidationInput.message, confirmAction: nil)
            return
        }
        guard let contact = newContact() else {
            return
        }
        delegate?.create(contact)
        reloadData?()
        self.dismiss(animated: true)
    }
    
    private func newContact() -> Contact? {
        guard let name = contactsAdditionModalView.nameTextField.text,
              let ageString = contactsAdditionModalView.ageTextField.text,
              let age = Int(ageString),
              let phoneNumber = contactsAdditionModalView.phoneNumberTextField.text else {
            return nil
        }
        return Contact(name: name, contact: phoneNumber, age: age)
    }
}

extension ContactsAdditionModalViewController {
    private func validateTextFields() -> InvalidationInput? {
        var invalidationInput: InvalidationInput? = nil
        sortedTextField.forEach { uiTextField in
            invalidationInput = invalidationInput == nil ? validate(regex: regexByTextField[uiTextField], input: uiTextField) : invalidationInput
        }
        return invalidationInput
    }
    
    private func validate(regex: String?, input: UITextField) -> InvalidationInput? {
        guard let inputText = input.text, let regexString: String = regex else {
            return invalidationByTextField[input]
        }
        
        let regexTest = NSPredicate(format: "SELF MATCHES %@", regexString)
        return regexTest.evaluate(with: inputText) ? nil : invalidationByTextField[input]
    }
}
