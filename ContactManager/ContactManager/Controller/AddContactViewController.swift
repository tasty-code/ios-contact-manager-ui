//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/11/23.
//

import UIKit

class AddContactViewController: UIViewController {
  private var manager: ContactManager
  @IBOutlet var nameTextField: UITextField!
  @IBOutlet var ageTextField: UITextField!
  @IBOutlet var phoneTextField: UITextField!
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  required init?(coder: NSCoder, manager: ContactManager) {
    self.manager = manager
    super.init(coder: coder)
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    guard let nameText = nameTextField.text else {
      print("alert")
      return
    }
    if !manager.nameValidate(nameText) {
      print("alert")
      return
    }
    
    guard let ageText = Int(ageTextField.text ?? "")  else {
      print("alert")
      return
    }
    if !manager.ageValidate(ageText) {
      print("alert")
      return
    }
    
    guard let phoneText = phoneTextField.text else {
      print("alert")
      return
    }
    if !manager.phoneValidate(phoneText) {
      print("alert")
      return
    }
    
    let newContact = Contact(name: nameText, age: ageText, phone: phoneText)
  }
}
