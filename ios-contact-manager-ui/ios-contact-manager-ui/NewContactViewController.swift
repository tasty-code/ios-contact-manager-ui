//
//  NewContectViewController.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/11.
//

import UIKit

protocol SendDelegate: AnyObject{
    func sendContact(newContact: Contact)
}

class NewContactViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var delegate: SendDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        keyboardSetting()
        phoneNumberTextField.delegate = self
    }
    
    private func navigationSetting() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    private func keyboardSetting() {
        nameTextField.keyboardType = .namePhonePad
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .phonePad
    }
}

extension NewContactViewController {
    @IBAction private func tappedCancelButton(_ sender: UIButton) {
        showCancelAlert()
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIButton) {
        guard let name = checkName() else {
            invalidAlert(invalid: nameTextField)
            return
        }
        guard let age = checkAge() else {
            invalidAlert(invalid: ageTextField)
            return
        }
        guard let number = checkNumber() else {
            invalidAlert(invalid: phoneNumberTextField)
            return
        }
        saveAlert(Contact(name: name, phoneNumber: number, age: age))
    }
    
    private func showCancelAlert() {
        let alert = UIAlertController(title: title, message: "정말 취소하겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { _ in self.dismiss(animated: true)}))
        alert.addAction(UIAlertAction(title: "아니오", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func saveAlert(_ contact: Contact) {
        let text: String = "이름: \(contact.name), \n 나이: \(contact.age), \n 연락처: \(contact.phoneNumber) \n 저장하시겠습니까?"
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            self.delegate?.sendContact(newContact: contact)
            self.dismiss(animated: true)}))
        alert.addAction(UIAlertAction(title: "아니오", style: .default, handler: { _ in return }))
        present(alert, animated: true)
    }
    
    private func checkName() -> String? {
        guard let name = nameTextField.text else {
            return nil
        }
        return name.isEmpty ? nil : name.components(separatedBy: " ").joined()
    }
    
    private func checkAge() -> Int? {
        guard let ageText = ageTextField.text, let age = Int(ageText) else {
            return nil
        }
        return age
    }
    
    private func checkNumber() -> String? {
        guard let number = phoneNumberTextField.text else {
            return nil
        }
        return number.count >= 11 && number.filter { $0 == "-" }.count == 2 ? number : nil
    }
    
    private func invalidAlert(invalid: UITextField) {
        var text: String
        
        switch invalid {
        case nameTextField:
            text = "이름"
        case ageTextField:
            text = "나이"
        case phoneNumberTextField:
            text = "연락처"
        default:
            return
        }
        
        let alert = UIAlertController(title: nil, message: "입력한 \(text) 정보가 잘못되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler:  nil))
        present(alert, animated: true)
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var number = phoneNumberTextField.text else { return false }
        
        if range.location == 2 && number.last != "-" {
            number.insert("-", at: number.index(number.startIndex, offsetBy: 2))
        }
        
        if range.location == 6 && number.last != "-" {
            number.insert("-", at: number.index(number.startIndex, offsetBy: 6))
        }
        
        if range.location == 11 {
            number = number.components(separatedBy: "-").joined()
            number.insert("-", at: number.index(number.startIndex, offsetBy: 2))
            number.insert("-", at: number.index(number.startIndex, offsetBy: 7))
        }
        
        if range.location == 12 {
            number = number.components(separatedBy: "-").joined()
            number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
            number.insert("-", at: number.index(number.startIndex, offsetBy: 8))
        }
        
        phoneNumberTextField.text = number
        return true
    }
}
