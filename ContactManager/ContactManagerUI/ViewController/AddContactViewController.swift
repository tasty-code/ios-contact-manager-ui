//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/06.
//

import UIKit

protocol AddContactViewControllerDelegate {
    func didContactChanged()
}

final class AddContactViewController: UIViewController {
    // MARK: - Properties
    var delegate: AddContactViewControllerDelegate?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var navigationBar: UINavigationBar!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        configureTextField()
    }
    
    // MARK: - Actions
    @IBAction private func tappedCancelButton(_ sender: UIBarButtonItem) {
        showCheckCancelAlert()
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text ,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        
        let inputArray = [name, age, phoneNumber]
        
        do {
            let contact = try InputManager.contact(from: inputArray)
            ContactManager.shared.add(contact: contact)
            dismiss(animated: true) {
                self.delegate?.didContactChanged()
            }
        } catch {
            showFailAlert(withTitle: error.localizedDescription)
        }
    }

    @objc func didPhoneNumberTextChange() {
        phoneNumberTextField.text = formattedPhoneNumber(with: phoneNumberTextField.text)
    }
    
    // MARK: - Helpers
    private func showFailAlert(withTitle title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Constants.failAlertActionTitle, style: .default)
        
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    private func showCheckCancelAlert() {
        let alert = UIAlertController(title: Constants.checkCancelAlertTitle, message: nil, preferredStyle: .alert)
        let noAction = UIAlertAction(title: Constants.checkCancelAlertNoActionTitle, style: .cancel)
        let yesAction = UIAlertAction(title: Constants.checkCancelAlertYesActionTitle, style: .destructive) { _ in self.dismiss(animated: true)
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }

    private func configureTextField() {
        nameTextField.delegate = self
        ageTextField.delegate = self

        phoneNumberTextField.addTarget(self, action: #selector(didPhoneNumberTextChange), for: .editingChanged)
    }
}

extension AddContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == ageTextField || textField == phoneNumberTextField {
            guard string.isEmpty || Int(string) != nil else {
                return false
            }
        }
        return true
    }
}

// MARK: - PhoneNumberTextField Format 관련
extension AddContactViewController {
    private func formattedPhoneNumber(with text: String?) -> String {
        let pureNumbers = text?.filter { $0.isNumber } ?? ""
        let pattern = createPhoneNumberPattern(with: pureNumbers)
            return applyPatternOn(pureNumbers: pureNumbers, pattern: pattern, replacementCharacter: "#")
    }

    private func createPhoneNumberPattern(with pureNumbers: String) -> String {
        if pureNumbers.starts(with: "0") && !pureNumbers.starts(with: "02")  {
            if pureNumbers.count <= 10 {
                return "###-###-####"
            }

            if pureNumbers.count == 11 {
                return "###-####-####"
            }
        }

        if pureNumbers.count <= 9 {
            return "##-###-####"
        }

        if pureNumbers.count == 10 {
            return "##-####-####"
        }

        return ""
    }

    private func applyPatternOn(pureNumbers: String,
                                pattern: String,
                                replacementCharacter: Character) -> String {
        var numbers = pureNumbers
        for index in 0 ..< pattern.count {
            guard index < numbers.count else { return numbers }
            let pattenIndex = pattern.index(pattern.startIndex, offsetBy: index)
            let patternCharacter = pattern[pattenIndex]

            guard patternCharacter != replacementCharacter else { continue }
            numbers.insert(patternCharacter, at: pattenIndex)
        }
        return numbers
    }
}
