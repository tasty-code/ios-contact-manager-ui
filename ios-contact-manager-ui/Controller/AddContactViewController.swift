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
    
    @objc func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", cancelTitle: "아니오", confirmTitle: "예") { [weak self] _ in self?.dismissModal() }
    }
    
    @objc func saveButtonTapped() {
        guard let name = removeEmptySpaceCharacter(nameTextField), name.isEmpty == false else { return presentNameAlert() }
        guard let age = removeEmptySpaceCharacter(ageTextField), age.isEmpty == false else { return presentAgeAlert() }
        guard let phoneNumber = removeEmptySpaceCharacter(phoneNumberTextField), phoneNumber.isEmpty == false else { return presentPhoneNumberAlert() }
            
        guard checkAgeTextField(age: age) else { return  presentAgeAlert() }
        guard checkPhoneNumberTextField(for: phoneNumber) else { return presentPhoneNumberAlert() }
        
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        delegate?.updateContactList(with: newContact)
        
        dismissModal()
    }
    
    func configureNavigationItem() {
        let dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    func configureTextField() {
        nameTextField.keyboardType = .emailAddress
        nameTextField.delegate = self
        ageTextField.keyboardType = .numberPad
        ageTextField.delegate = self
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.delegate = self
    }
    
    func checkAgeTextField(age: String) -> Bool {
        guard let ageNumber = Int(age), 0 < ageNumber, ageNumber <= 999 else {
            return false
        }
        return true
    }
    
    func checkPhoneNumberTextField(for phoneNumber: String) -> Bool {
        let onlyNumber = phoneNumber.extractNumbersFromStrings()
        let regexPattern = "^[0-9]+-[0-9]+-[0-9]+$"
        
        guard checkDigitsOver(number: 9, for: onlyNumber) else {
            print("\(TextFieldError.phoneNumberTextFieldError.ErrorMessage)")
            presentPhoneNumberAlert()
            return false
        }
        
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            guard regex.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) != nil else {
                print("\(TextFieldError.phoneNumberTextFieldError.ErrorMessage)")
                return false
            }
            return true
        } catch {
            print("\(TextFieldError.phoneNumberTextFieldError.ErrorMessage)")
            return false
        }
    }
    
    func checkDigitsOver(number: Int, for phoneNumber: String) -> Bool {
        if phoneNumber.count < number {
            return false
        } else {
            return true
        }
    }
    
    func removeEmptySpaceCharacter(_ textField: UITextField) -> String? {
        return textField.text?.filter { $0.isWhitespace == false }
    }

    func dismissModal() {
        self.dismiss(animated: true)
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

extension AddContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            guard let currnetText = textField.text as NSString? else { return false }
            let newString = currnetText.replacingCharacters(in: range, with: string)
            let formattedPhoneNumber = newString.formatPhoneNumber()
            textField.text = formattedPhoneNumber
            return false
        }
        return true
    }
}
