//
//  AddContanctViewController.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/10/24.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func updateContactList(with contact: Contact)
}

class AddContactViewController: UIViewController {
    
    var addedContactList: [Contact] = []
    weak var delegate: SendDataDelegate?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTextField()
    }
    
    func configureTextField() {
        nameTextField.keyboardType = .emailAddress
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .numbersAndPunctuation
    }
    
    func removeEmptySpaceCharacter(_ textField: UITextField) -> String? {

        return textField.text?.filter { !$0.isWhitespace }
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }

    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", confirmTitle: "예", cancelTitle: "아니오") { [weak self] _ in self?.dismissModal() }
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        guard let name = removeEmptySpaceCharacter(nameTextField), !name.isEmpty else { return presentNameAlert() }
        guard let age = removeEmptySpaceCharacter(ageTextField), !age.isEmpty else { return presentAgeAlert() }
        guard let phoneNumber = removeEmptySpaceCharacter(phoneNumberTextField), !phoneNumber.isEmpty else { return presentPhoneNumberAlert() }
            
        if !checkAgeTextField(age: age) {
            return presentAgeAlert()
        }
        
        if !checkPhoneNumberTextField(for: phoneNumber) {
            return presentPhoneNumberAlert()
        }
        
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        delegate?.updateContactList(with: newContact)
        self.dismiss(animated: true)
    }
    
    func checkDigitsOver(number: Int, for phoneNumber: String) -> Bool {
        if phoneNumber.count < number {
            return false
        } else {
            return true
        }
    }
    
    func checkPhoneNumberTextField(for phoneNumber: String) -> Bool {
        let onlyNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        let isNumberOkay = checkDigitsOver(number: 9, for: onlyNumber)
        let regexPattern = "^[0-9]+-[0-9]+-[0-9]+$"
        
        if isNumberOkay {
            do {
                let regex = try NSRegularExpression(pattern: regexPattern)
                if let _ = regex.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) {
                    return true
                }
            } catch {
                print("에러: 전화번호 정상 아님")
            }
        } else {
            print("에러: 자리수가 9개 미만입니다.")
        }
        return false
    }
    
    func checkAgeTextField(age: String) -> Bool {
        if let ageNumber = Int(age) {
            return ageNumber > 0 && ageNumber <= 999
        }
        
        return false
    }
    
    //MARK: - Alert 구현
    func presentNameAlert() {
        presentAlert(title: "\(TextFieldError.nameTextFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
    
    func presentAgeAlert() {
        presentAlert(title: "\(TextFieldError.ageTextFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
    
    func presentPhoneNumberAlert() {
        presentAlert(title: "\(TextFieldError.phoneNumberTextFieldError.ErrorMessage)", message: "", confirmTitle: "확인")
    }
}
