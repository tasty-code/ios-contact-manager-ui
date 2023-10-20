//
//  FormViewController.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/20.
//

import UIKit

class FormViewController: UIViewController {
  
  var contactChangedDelegate: ContactChangedDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func saveButtonTapped(_ sender: UIButton) {
  }
  
  func cancelButtonTapped(_ sender: UIButton) {
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
}
