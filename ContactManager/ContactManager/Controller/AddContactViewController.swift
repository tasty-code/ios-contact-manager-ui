//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/11/23.
//

import UIKit

final class AddContactViewController: UIViewController {
  var contactAddDelegate: ContactAddDelegate?
  var contactChangedDelegate: ContactChangedDelegate?
  
  @IBOutlet private var nameTextField: UITextField!
  @IBOutlet private var ageTextField: UITextField!
  @IBOutlet private var phoneTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction private func saveButtonTapped(_ sender: UIButton) {
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
  
  @IBAction private func cancelButtonTapped(_ sender: UIButton) {
    AlertViewController.show(on: self,
                             message: "정말로 취소하시겠습니까?",
                             defaultButtonTitle: "아니오",
                             destructiveButtonTitle: "예",
                             destructiveAction: {
      self.dismiss(animated: true)
    })
  }
  
  @IBAction private func phoneTextDidChanged(_ sender: UITextField) {
    sender.text = sender.text?.formatingPhone()
  }
}
