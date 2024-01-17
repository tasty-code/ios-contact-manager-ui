//
//  ContactsAdditionModalViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

final class ContactsAdditionModalViewController: UIViewController {
    private weak var delegate: ContactsManageable?
    private let contactsAdditionModalView: ContactsAddtionModalView
    private var sortedTextField: Dictionary<TextField, UITextField> {
        [
            .name : contactsAdditionModalView.nameTextField,
            .age : contactsAdditionModalView.ageTextField,
            .phoneNumber : contactsAdditionModalView.phoneNumberTextField
        ]
    }
    private var reloadData: (() -> Void)?
    
    init(delegate: ContactsManageable?) {
        contactsAdditionModalView = ContactsAddtionModalView()
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        
        contactsAdditionModalView.phoneNumberTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contactsAdditionModalView
        contactsAdditionModalView.setDelegate(delegate: self)
    }
}

extension ContactsAdditionModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
            return false
        }
        var rangeLocation = range.location
        var isNumberStartedWithZero: Bool = false
        
        let seoulNumber: String = "02"
        
        if text.starts(with: "0") && !text.starts(with: seoulNumber) {
            text.removeFirst()
            rangeLocation -= 1
            isNumberStartedWithZero = true
        }
        
        text = string == "" ? deleteText(text, range: rangeLocation) : appendText(text, range: rangeLocation)
        text = isNumberStartedWithZero ? "0" + text : text

        textField.text = text
        return true
    }
    
    private func appendText(_ text: String, range: Int) -> String {
        var replacementText = text
        
        switch range {
        case 2, 6:
            replacementText += "-"
        case 11:
            replacementText = exchange(string: replacementText, at: 7, isDelete: false)
        default:
            break
        }
        return replacementText
    }
    
    private func deleteText(_ text: String, range: Int) -> String {
        var replacementText = text
        
        switch range {
        case 3, 7:
            replacementText.removeLast()
        case 11:
            replacementText = exchange(string: replacementText, at: 6, isDelete: true)
        default:
            break
        }
        
        return replacementText
    }
    
    private func exchange(string: String, at index: Int, isDelete: Bool) -> String {
        var textArray: Array<Character> = Array(string)
        let characterToBeExchanged: Character = textArray[index]
        textArray[index] = "-"
        
        switch isDelete {
        case true:
            textArray[index + 1] = characterToBeExchanged
            textArray.removeLast()
        case false:
            textArray[index - 1] = characterToBeExchanged
        }
        
        return String(textArray)
    }
}

extension ContactsAdditionModalViewController {
    public func setReloadData(reloadData: (() -> Void)?) {
        self.reloadData = reloadData
    }
    
    @objc func dismissContactsAdditionModalView() {
        makeCancelAlert(message: "정말로 취소하시겠습니까?", destructiveAction: { _ in self.dismiss(animated: true) })
    }
    
    @objc func handleSaveButtonTap() {
        if let invalidationMessage = validateTextFields() {
            makeAlert(message: invalidationMessage, confirmAction: nil)
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
        return Contact(name: name, phoneNumber: phoneNumber, age: age)
    }
}

extension ContactsAdditionModalViewController {
    private func validateTextFields() -> String? {
        var message: String? = nil
        
        for field in TextField.allCases {
            guard let input = sortedTextField[field] else {
                return nil
            }
            let regexTest = NSPredicate(format: "SELF MATCHES %@", field.regex)
            message = message == nil && !regexTest.evaluate(with: input.text) ? field.message : message
        }
        
        return message
    }
}
