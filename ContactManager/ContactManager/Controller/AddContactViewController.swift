//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/11/23.
//

import UIKit

class AddContactViewController: UIViewController {
  private var manager: ContactManager
  private let alertViewController = AlertViewController()
  @IBOutlet private var nameTextField: UITextField!
  @IBOutlet private var ageTextField: UITextField!
  @IBOutlet private var phoneTextField: UITextField!
  
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
  
  @IBAction private func saveButtonTapped(_ sender: UIButton) {
    do {
      try manager.addContact(nameText: nameTextField.text,
                             ageText: ageTextField.text,
                             phoneText: phoneTextField.text)
      dismiss(animated: true)
    } catch {
      guard let errorType = error as? ValidationError else {
        print(error.localizedDescription)
        return
      }
      let customAlertData = AlertData(viewController: self, 
                                      message: errorType.errorMessage,
                                      defaultButtonTitle: "확인")
      alertViewController.showAlert(customAlertData)
    }
  }
  
  @IBAction private func cancelButtonTapped(_ sender: UIButton) {
    let customAlertData = AlertData(viewController: self,
                                    message: "정말로 취소하시겠습니까?",
                                    defaultButtonTitle: "아니오",
                                    destructiveButtonTitle: "예",
                                    destructiveAction: {
                                      self.dismiss(animated: true)
                                    })
    alertViewController.showAlert(customAlertData)
  }
  
  @IBAction private func phoneTextDidChanged(_ sender: UITextField) {
    sender.text = sender.text?.formatingPhone()
  }
}

// MARK: - extension

extension String {
  func formatingPhone() -> String {
    let _str = self.replacingOccurrences(of: "-", with: "")
    if(self.count > 12) { return self }
    
    var regexPattern: String
    if _str.count == 9 {
      regexPattern = "([0-9]{0,2})([0-9]{0,3})([0-9]{0,4})"
    } else {
      regexPattern = "([0-9]{0,3})([0-9]{0,4})([0-9]{0,4})"
    }
    
    if let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) {
      let modString = regex.stringByReplacingMatches(in: _str,
                                                     options: [],
                                                     range: NSRange(_str.startIndex..., in: _str),
                                                     withTemplate: "$1-$2-$3")
      return modString.trimmingCharacters(in: ["-"])
    }
    
    return _str
  }
}
