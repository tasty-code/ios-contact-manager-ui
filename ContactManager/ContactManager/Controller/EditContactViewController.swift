//
//  EditContactViewController.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/20.
//

import UIKit

class EditContactViewController: FormViewController {
  var editContactDelegate: ContactEditDelegate?
  var contactData: Contact?
  
  override func viewDidLoad() {
    nameTextField.text = contactData?.name
    ageTextField.text = contactData?.age.description
    phoneTextField.text = contactData?.phone
  }
  
  @IBAction override func saveButtonTapped(_ sender: UIButton) {
    super.saveButtonTapped(sender)
    
    guard let uid = contactData?.uid else { return }
    guard let (name, age, phone) = validData else { return }
    editContactDelegate?.editContact(uid: uid, name: name, age: age, phone: phone)
    contactChangedDelegate?.reload()
    dismiss(animated: true)
  }
  
  @IBAction override func cancelButtonTapped(_ sender: UIButton) {
    super.cancelButtonTapped(sender)
  }
  
  @IBAction override func phoneTextDidChanged(_ sender: UITextField) {
    super.phoneTextDidChanged(sender)
  }
}
