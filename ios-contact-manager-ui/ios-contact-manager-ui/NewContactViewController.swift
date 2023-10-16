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
    var isHyphen = [false, false]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        keyboardSetting()
        self.phoneNumberTextField.addTarget(self, action: #selector(self.didChangePhoneNumberTextField(_:)), for: .editingChanged)
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
        guard let name = nameCheck() else {
            invalidAlert(invalid: nameTextField)
            return
        }
        guard let age = ageCheck() else {
            invalidAlert(invalid: ageTextField)
            return
        }
        guard let number = numberCheck() else {
            invalidAlert(invalid: phoneNumberTextField)
            return
        }
        saveAlert(Contact(name: name, phoneNumber: number, age: age))
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
    
    func nameCheck() -> String? {
        guard let name = nameTextField.text else {
            return nil
        }
        return name == "" ? nil : name.components(separatedBy: " ").joined()
    }
    
    func ageCheck() -> Int? {
        guard let ageText = ageTextField.text, let age = Int(ageText) else {
            return nil
        }
        return age
    }
    
    func numberCheck() -> String? {
        guard let number = phoneNumberTextField.text else {
            return nil
        }
        return number.count >= 11 && !isHyphen.contains(false) ? number : nil
    }
    
    @objc func didChangePhoneNumberTextField(_ send: Any?) {
        guard var number = phoneNumberTextField.text else { return }
        let mobile: [String] = ["010"]
        let seoulLocal: String = "02-"
        var special: [String] = mobile
        special.append(seoulLocal)
        
        if number.count == 0 {
            isHyphen = [false, false]
            return
        }
        
        // 010 핸드폰
        if number.count == 4 && mobile.contains(String(number.prefix(3))) {
            if !isHyphen[0] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
            }
            isHyphen[0].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        if number.count == 9 && mobile.contains(String(number.prefix(3))) {
            if  !isHyphen[1] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 8))
            }
            isHyphen[1].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        // ETC 지역번호
        if number.count == 4 && !special.contains(String(number.prefix(3))) {
            if  !isHyphen[0] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
            }
            isHyphen[0].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        if number.count == 8 && !special.contains(String(number.prefix(3))) {
            if !isHyphen[1] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 7))
            }
            isHyphen[1].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        if number.count == 13 && !special.contains(String(number.prefix(3))) {
            number = number.components(separatedBy: "-").joined()
            number.insert("-", at: number.index(number.startIndex, offsetBy: 3))
            number.insert("-", at: number.index(number.startIndex, offsetBy: 8))
            phoneNumberTextField.text = number
            return
        }
        
        //02
        if number.count == 3 && seoulLocal.contains(String(number.prefix(2))) {
            if !isHyphen[0] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 2))
            }
            isHyphen[0].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        if number.count == 7 && seoulLocal.contains(String(number.prefix(2))) {
            if !isHyphen[1] {
                number.insert("-", at: number.index(number.startIndex, offsetBy: 6))
            }
            isHyphen[1].toggle()
            phoneNumberTextField.text = number
            return
        }
        
        if number.count == 12 && seoulLocal.contains(String(number.prefix(2))) {
            number = number.components(separatedBy: "-").joined()
            number.insert("-", at: number.index(number.startIndex, offsetBy: 2))
            number.insert("-", at: number.index(number.startIndex, offsetBy: 7))
            phoneNumberTextField.text = number
            return
        }
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

