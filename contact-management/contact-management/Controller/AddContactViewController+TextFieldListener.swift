//
//  AddContactViewController+View.swift
//  contact-management
//
//  Created by Roh on 1/20/24.
//

import UIKit

extension AddContactViewController {
    func addTextField() {
        nameTextField.addTarget(self, action: #selector(nameFieldDidChange(_:)), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(ageFieldDidChange(_:)), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(phoneFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func nameFieldDidChange(_ nameField: UITextField) {
        nameContact = nameField.text
    }
    
    @objc func ageFieldDidChange(_ ageField: UITextField) {
        guard let age = ageField.text else {
            return
        }
        ageContact = Int(age)
    }
    
    @objc func phoneFieldDidChange(_ phoneField: UITextField) {
        guard let phone = phoneField.text else { return }
        phoneField.text = phoneFormat?.addCharacter(at: phone)
        phoneContact = phoneField.text
    }
}
