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
    do {
      let newContact = try makeContact()
      manager.addContact(data: newContact)
      dismiss(animated: true)
    } catch {
      guard let errorType = error as? ValidateError else {
        print(error.localizedDescription)
        return
      }
      AlertViewController().showAlert(self: self, message: errorType.errorMessage, defaultButtonTitle: "확인")
    }
  }
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    AlertViewController().showAlert(self: self, message: "정말로 취소하시겠습니까?", defaultButtonTitle: "아니오", destructiveButtonTitle: "예", destructiveAction: {
      self.dismiss(animated: true)
    })
  }

  private func makeContact() throws -> Contact {
    let nameText = try manager.nameValidate(nameTextField.text)
    let ageText = try manager.ageValidate(ageTextField.text)
    let phoneText = try manager.phoneValidate(phoneTextField.text)
    
    return Contact(name: nameText, age: ageText, phone: phoneText)
  }
}
