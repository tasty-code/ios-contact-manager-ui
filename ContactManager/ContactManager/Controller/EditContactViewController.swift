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
  
  @IBOutlet weak private var nameTextField:UITextField!
  @IBOutlet weak private var ageTextField:UITextField!
  @IBOutlet weak private var phoneTextField:UITextField!
  
  override func viewDidLoad() {
    nameTextField.text = contactData?.name
    ageTextField.text = contactData?.age.description
    phoneTextField.text = contactData?.phone
  }
  
  @IBAction override func saveButtonTapped(_ sender: UIButton) {
    do {
      guard let uid = contactData?.uid else { return }
      try editContactDelegate?.editContact(uid: uid, nameText: nameTextField.text, ageText: ageTextField.text, phoneText: phoneTextField.text)
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
