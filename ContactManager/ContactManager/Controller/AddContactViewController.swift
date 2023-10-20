//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/11/23.
//

import UIKit

final class AddContactViewController: FormViewController {

  weak var contactAddDelegate: ContactAddDelegate?
  
  @IBAction override func saveButtonTapped(_ sender: UIButton) {
    super.saveButtonTapped(sender)
    guard let (name, age, phone) = validData else { return }
    contactAddDelegate?.addContact(name: name,
                                   age: age,
                                   phone: phone)
    contactChangedDelegate?.reload()
    dismiss(animated: true)
  }
}
