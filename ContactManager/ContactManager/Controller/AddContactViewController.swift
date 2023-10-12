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
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    let alert = UIAlertController(title: "", message: "정말로 취소하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
    let alertNoAction = UIAlertAction(title: "아니오", style: .destructive)
    let alertYesAction = UIAlertAction(title: "예", style: .default) { _ in
      self.dismiss(animated: true)
    }
    alert.addAction(alertNoAction)
    alert.addAction(alertYesAction)
    present(alert, animated: true)
  }
  
  func showAlert(message: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: "확인", style: .default)
    alert.addAction(alertAction)
    present(alert, animated: true)
  }
  
  private func makeContact() throws -> Contact {
    let nameText = try manager.nameValidate(nameTextField.text)
    let ageText = try manager.ageValidate(ageTextField.text)
    let phoneText = try manager.phoneValidate(phoneTextField.text)
    
    return Contact(name: nameText, age: ageText, phone: phoneText)
  }
}
