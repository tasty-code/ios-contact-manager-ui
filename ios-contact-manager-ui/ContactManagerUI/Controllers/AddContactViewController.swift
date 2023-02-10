//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/6/23.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var contactTextField: UITextField!
    
    weak var newContactDelegate: NewContactDelegate?

    private let contactTextHyphenPolicyLength = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        contactTextField.delegate = self
    }
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              let age = ageTextField.text,
              let contact = contactTextField.text else {
            return
        }

        do {
            let newContact = try UserInfo(name: name, age: age, phone: contact)
            ContactsController.shared.add(user: newContact)
            newContactDelegate?.addNewContact()
            dismiss(animated: true)
        } catch {
            makeErrorAlert(description: error.localizedDescription)
        }
    }
    
    @IBAction private func cancelButtonTapped(_ sender: Any) {
        makeCancelAlert()
    }
}

extension AddContactViewController {
    private func makeErrorAlert(description: String) {
        let alert = UIAlertController(
            title: description,
            message: nil,
            preferredStyle: .alert
        )
        let checkAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(checkAction)
        present(alert, animated: true)
    }
    
    private func makeCancelAlert() {
        let alert = UIAlertController(
            title: "정말로 취소하시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        let noAction = UIAlertAction(title: "아니오", style: .default)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        alert.preferredAction = yesAction
        present(alert, animated: true)
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let oldText = textField.text, let textRange = Range(range, in: oldText) {
            let newText = oldText.replacingCharacters(in: textRange, with: string)
            textField.text = parse(newText, using: range)
        }
        return false
    }
    
    private enum LocationsOfHyphen {
        static let forTwoFourFour = [2, 7]
        static let forTwoThreeFour = [2, 6]
        static let forThreeFourFour = [3, 8]
    }

    private func parse(_ newText: String, using range: NSRange) -> String {
        let digitString = newText.replacingOccurrences(of: String.hyphen, with: String.empty)
        switch digitString.count {
        case ..<contactTextHyphenPolicyLength:
            return relocateHyphen(of: digitString, at: LocationsOfHyphen.forTwoThreeFour)
        case contactTextHyphenPolicyLength:
            return relocateHyphen(of: digitString, at: LocationsOfHyphen.forTwoFourFour)
        default:
            return relocateHyphen(of: digitString, at: LocationsOfHyphen.forThreeFourFour)
        }
    }
    
    private func removeLastHyphen(from text: String) -> String {
        if text.last == Character.hyphen {
            return String(text.dropLast())
        }
        return text
    }
    
    private func relocateHyphen(of string: String, at indices: [Int]) -> String {
        var relocated = string
        for (index, stringIndex) in indices.enumerated() where stringIndex - index < string.count {
            relocated.insert(Character.hyphen, at: stringIndex)
        }
        return relocated
    }
}
