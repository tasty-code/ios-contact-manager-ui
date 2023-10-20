//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/11/23.
//

import UIKit

final class AddContactViewController: FormViewController {

  @IBOutlet private weak var nameTextField: UITextField!
  @IBOutlet private weak var ageTextField: UITextField!
  @IBOutlet private weak var phoneTextField: UITextField!
  
  @IBAction override func saveButtonTapped(_ sender: UIButton) {
    do {
      try contactAddDelegate?.addContact(nameText: nameTextField.text,
                                         ageText: ageTextField.text,
                                         phoneText: phoneTextField.text)
      contactChangedDelegate?.reload()
      dismiss(animated: true)
    } catch {
      AlertViewController.show(on: self,
                               message: error.localizedDescription,
                               defaultButtonTitle: "확인")
    }
  }
  
  @IBAction override func cancelButtonTapped(_ sender: UIButton) {
    super.cancelButtonTapped(sender)
  }
  
  @IBAction override func phoneTextDidChanged(_ sender: UITextField) {
    super.phoneTextDidChanged(sender)
  }
}
