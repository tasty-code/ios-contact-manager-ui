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
    }
    
    func navigationSetting() {
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
    }
    
    func keyboardSetting() {
        nameTextField.keyboardType = .namePhonePad
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .phonePad
    }
}


extension NewContactViewController {
    @IBAction func tappedCancelButton(_ sender: UIButton) {
        cancelAlert()
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        let textField: [UITextField] = [nameTextField, ageTextField, phoneNumberTextField]
        
        for text in textField {
            if text.text == "" {
                invalidAlert(invalid: text)
                return
            }
        }
//        guard let stringAge = ageTextField.text, let age = Int(stringAge) else { print("ddddd"); return }
//        saveAlert(Contact(name: nameCheck(name: name),phoneNumber: phoneNumber, age: age ))
    }
    
    func cancelAlert() {
        let alert = UIAlertController(title: title, message: "정말 취소하겠습니까?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { _ in self.dismiss(animated: true)}))
        alert.addAction(UIAlertAction(title: "아니오", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    func saveAlert(_ contact: Contact) {
        let text: String = "이름: \(contact.name), \n 나이: \(contact.age), \n 연락처: \(contact.phoneNumber) \n 저장하시겠습니까?"
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            self.delegate?.sendContact(newContact: contact)
            self.dismiss(animated: true)}))
        alert.addAction(UIAlertAction(title: "아니오", style: .default, handler: { _ in return }))
        present(alert, animated: true)
    }
    
    func nameCheck(name: String) -> String {
        return name.components(separatedBy: " ").joined()
    }

    func invalidAlert(invalid: UITextField) {
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

