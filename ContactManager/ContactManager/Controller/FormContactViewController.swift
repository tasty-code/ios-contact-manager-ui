//
//  FormViewController.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/20.
//

import UIKit

class FormViewController: UIViewController {
  
  weak var contactChangedDelegate: ContactChangedDelegate?
  var validData: (String, Int, String)?
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    do {
      validData = try getValidData(nameText: nameTextField.text,
                                   ageText: ageTextField.text,
                                   phoneText: phoneTextField.text)
    } catch {
      AlertViewController.show(on: self,
                               message: error.localizedDescription,
                               defaultButtonTitle: "확인")
    }
  }
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    AlertViewController.show(on: self,
                             message: "정말로 취소하시겠습니까?",
                             defaultButtonTitle: "아니오",
                             destructiveButtonTitle: "예",
                             destructiveAction: {
      self.dismiss(animated: true)
    })
  }
  
  @IBAction func phoneTextDidChanged(_ sender: UITextField) {
    sender.text = sender.text?.formatingPhone()
  }
  
  private func getValidData(nameText: String?, ageText: String?, phoneText: String?) throws -> (String, Int, String) {
    let name = try nameText.getValidName()
    let age = try ageText.getValidAge()
    let phone = try phoneText.getValidPhone()
    
    return (name: name, age: age, phone: phone)
  }
}
