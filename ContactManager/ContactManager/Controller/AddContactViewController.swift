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
      let newContact = try getCurrentText()
    } catch {
      switch error {
      case ValidateError.nameValidateError:
        showAlert(message: ValidateError.nameValidateError.errorMessage)
      case ValidateError.ageValidateError:
        showAlert(message: ValidateError.ageValidateError.errorMessage)
      case ValidateError.phoneValidateError:
        showAlert(message: ValidateError.phoneValidateError.errorMessage)
      default:
        print(error.localizedDescription)
      }
    }
  }
  
  func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: "확인", style: .default)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
  
  func getCurrentText() throws -> Contact {
    guard let nameText = nameTextField.text else {
      throw ValidateError.nameValidateError
    }
    if !manager.nameValidate(nameText) {
      throw ValidateError.nameValidateError
    }
    
    guard let ageText = Int(ageTextField.text ?? "")  else {
      throw ValidateError.nameValidateError
    }
    if !manager.ageValidate(ageText) {
      throw ValidateError.nameValidateError
    }
    
    guard let phoneText = phoneTextField.text else {
      throw ValidateError.nameValidateError
    }
    if !manager.phoneValidate(phoneText) {
      throw ValidateError.nameValidateError
    }
    
    return Contact(name: nameText, age: ageText, phone: phoneText)
  }
}
