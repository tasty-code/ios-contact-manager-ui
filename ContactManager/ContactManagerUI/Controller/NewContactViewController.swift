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
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let noButton = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(noButton)
        let yesButton = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(yesButton)
        present(alert, animated: true)
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
            showErrorAlert(error.localizedDescription)
        }
    }

    private func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let checkButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(checkButton)
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
