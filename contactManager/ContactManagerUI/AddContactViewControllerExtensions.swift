//
//  AddContactViewControllerExtensions.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/02/07.
//

import UIKit

extension AddContactViewController: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == nameTextField {
            ageTextField.becomeFirstResponder()
        }
        return true
    }
}
