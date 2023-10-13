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
  
  @IBAction func phoneTextDidChanged(_ sender: UITextField) {
    sender.text = sender.text?.pretty()
  }
}


// MARK: - extension

extension String {
  func pretty() -> String {
    let _str = self.replacingOccurrences(of: "-", with: "")
    if(self.count > 12) { return self }
    
    let prefix = _str.prefix(2)
    if prefix == "02" {
      if let regex = try? NSRegularExpression(pattern:"([0-9]{0,2})([0-9]{0,4})([0-9]{0,4})",
                                              options: .caseInsensitive) {
        let modString = regex.stringByReplacingMatches(in: _str,
                                                       options: [],
                                                       range: NSRange(_str.startIndex..., in: _str),
                                                       withTemplate: "$1-$2-$3")
        return modString.trimmingCharacters(in: ["-"])
      }
    } else { // 나머지는 휴대폰번호 (010-xxxx-xxxx, 031-xxx-xxxx, 061-xxxx-xxxx 식이라 상관무)
      if let regex = try? NSRegularExpression(pattern: "([0-9]{0,3})([0-9]{0,4})([0-9]{0,4})",
                                              options: .caseInsensitive) {
        let modString = regex.stringByReplacingMatches(in: _str,
                                                       options: [],
                                                       range: NSRange(_str.startIndex..., in: _str),
                                                       withTemplate: "$1-$2-$3")
        return modString.trimmingCharacters(in: ["-"])
      }
    }
    return self
  }
}
