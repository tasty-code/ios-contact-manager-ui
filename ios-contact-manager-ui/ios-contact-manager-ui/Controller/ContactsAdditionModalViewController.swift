//
//  ContactsAdditionModalViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

final class ContactsAdditionModalViewController: UIViewController {
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

extension ContactsAdditionModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
            return false
        }
        var rangeLocation = range.location
        var isNumberStartedWithZero: Bool = false
        
        var isSeoulNumber: Bool = false
        if text.count > 1 {
            isSeoulNumber = text.starts(with: "0") && text[text.index(after: text.startIndex)] == "2"
        }
        
        if text.starts(with: "0") && !isSeoulNumber {
            text.removeFirst()
            rangeLocation -= 1
            isNumberStartedWithZero = true
        }
        
        text = string == "" ? deleteKeyTapped(text: text, rangeLocation: rangeLocation) : numberKeyTapped(text: text, rangeLocation: rangeLocation)
        text = isNumberStartedWithZero ? "0" + text : text

        textField.text = text
        return true
    }
    
    private func numberKeyTapped(text: String, rangeLocation: Int) -> String {
        var resultText = text
        
        switch rangeLocation {
        case 2, 6:
            resultText += "-"
        case 11:
            resultText = exchange(string: resultText, of: 7, isDelete: false)
        default:
            break
        }
        return resultText
    }
    
    private func deleteKeyTapped(text: String, rangeLocation: Int) -> String {
        var resultText = text
        
        switch rangeLocation {
        case 3, 7:
            resultText.removeLast()
        case 11:
            resultText = exchange(string: resultText, of: 6, isDelete: true)
        default:
            break
        }
        
        return resultText
    }
    
    private func exchange(string: String, of: Int, isDelete: Bool) -> String {
        var textArray: Array<Character> = Array(string)
        let characterToBeExchanged: Character = textArray[of]
        textArray[of] = "-"
        
        switch isDelete {
        case true:
            textArray[of + 1] = characterToBeExchanged
            textArray.removeLast()
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
