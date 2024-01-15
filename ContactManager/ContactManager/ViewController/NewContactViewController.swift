//
//  NewContactViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 2024/01/12.
//

import UIKit

class NewContactViewController: UIViewController, CustomAlert {
    let contactFileManager: ContactFileManager
    weak var delegate: UpdateNewContact?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    init?(coder: NSCoder, contactFileManager: ContactFileManager) {
        self.contactFileManager = contactFileManager
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeKeyboardType()
        phoneNumberTextField.delegate = self
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        let cancel = UIAlertAction(title: "아니오", style: .default)
        let ok = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        showAlert(message: "정말로 취소하시겠습니까?", actions: [cancel, ok])
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
               let ageString = ageTextField.text,
               let phone = phoneNumberTextField.text else { return }
        guard let age = Int(ageString) else { return }
        contactFileManager.addContact(contact: Contact(name: name, age: age, phoneNumber: phone))
        let cancel = UIAlertAction(title: "아니오", style: .default)
        let ok = UIAlertAction(title: "예", style: .default) { _ in
            self.delegate?.updateNewContact()
            self.dismiss(animated: true)
        }
        showAlert(message: "입력한 정보가 맞는지 확인하세요.", actions: [cancel, ok])
    }
}
extension NewContactViewController {
    func changeKeyboardType() {
        nameTextField.keyboardType = .default
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numberPad
    }
}

extension NewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard var text = textField.text else { return false }
        
        switch (text.hasPrefix("02"), text.count, string.isEmpty) {
                case (true, 2, false), (true, 6, false):
                    text += "-"
                case (false, 3, false), (false, 7, false):
                    text += "-"
                case (true, 4, true), (true, 8,true):
                    if string.isEmpty {
                        text.removeLast()
                    }
                case (false, 4,true), (false, 8,true):
                    if string.isEmpty {
                        text.removeLast()
                    }
                case (true, 11, false), (false, 12, false):
                    if let lastHyphenIndex = text.lastIndex(of: "-") {
                        text.remove(at: lastHyphenIndex)
                        let indexToAddHyphen = text.index(text.endIndex, offsetBy: -3)
                        text.insert("-", at: indexToAddHyphen)
                    }
                case (true, 12..., false), (false, 14..., false):
                    text = text.replacingOccurrences(of: "-", with: "")
                default:
                    break
                }
                textField.text = text
                return true
    }
}
