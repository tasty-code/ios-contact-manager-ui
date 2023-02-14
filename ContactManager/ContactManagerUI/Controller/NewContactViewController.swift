//
//  NewContactViewController.swift
//  ContactManagerUI
//
//  Created by jun on 2023/02/07.
//

import UIKit

final class NewContactViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!

    weak var delegate: NewContactViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
    }

    @IBAction private func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        let cancelTitle = "정말로 취소하시겠습니까?"
        showAlert(title: cancelTitle, leftButtonTitle: "아니오", rightButtonTitle: "예")
    }

    @IBAction private func saveButtonDidTap(_ sender: UIBarButtonItem) {
        do {
            let name = try getName(input: nameTextField.text ?? "")
            let age = try getAge(input: ageTextField.text ?? "")
            try isValidPhoneNumber(phoneNumberTextField.text ?? "")
            let phoneNumber = phoneNumberTextField.text ?? ""
            let contact = Contact(name: name, age: age, phoneNumber: phoneNumber)
            delegate?.sendData(contact: contact)
            dismiss(animated: true)
        } catch {
            showAlert(title: error.localizedDescription, leftButtonTitle: "확인")
        }
    }

    private func showAlert(title: String, leftButtonTitle: String, rightButtonTitle: String? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let leftButton = UIAlertAction(title: leftButtonTitle, style: .default)
        alert.addAction(leftButton)
        if rightButtonTitle != nil {
            let rightButton = UIAlertAction(title: rightButtonTitle, style: .destructive) { _ in
                   self.dismiss(animated: true)
               }
            alert.addAction(rightButton)
        }
        present(alert, animated: true)
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField, let text = textField.text {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            let stringOfNumber = newString.filter { $0.isNumber }
            let phoneFormatter = PhoneFormatter()
            textField.text = phoneFormatter.string(for: stringOfNumber)
            return false
        }
        return true
    }
}
