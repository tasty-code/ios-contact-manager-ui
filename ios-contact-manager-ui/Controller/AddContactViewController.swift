//
//  AddContanctViewController.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/10/24.
//

import UIKit

// MARK: - Delegate Pattern
protocol AddContactDelegate: AnyObject {
    func updateContactList(with contact: Contact)
}

final class AddContactViewController: UIViewController {
        
    // MARK: - Properties
    private var addedContactList: [Contact] = []
    weak var delegate: AddContactDelegate?
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var ageTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTextField()
    }
    
    //MARK: - Custom Methods(Button)
    @objc private func cancelButtonTapped() {
        presentAlertWithCancel(title: "정말로 취소하시겠습니까?", message: "", cancelTitle: "아니오", confirmTitle: "예") { [weak self] _ in self?.dismissModal() }
    }
    
    @objc private func saveButtonTapped() {
        guard let name = removeEmptySpaceCharacter(nameTextField), name.isEmpty == false else { return presentNameAlert() }
        guard let age = removeEmptySpaceCharacter(ageTextField), age.isEmpty == false else { return presentAgeAlert() }
        guard let phoneNumber = removeEmptySpaceCharacter(phoneNumberTextField), phoneNumber.isEmpty == false else { return presentPhoneNumberAlert() }
        
        guard checkAgeTextField(age: age) else { return  presentAgeAlert() }
        guard checkPhoneNumberTextField(for: phoneNumber) else { return presentPhoneNumberAlert() }
        
        let newContact = Contact(name: name, age: age, phoneNumber: phoneNumber)
        delegate?.updateContactList(with: newContact)
        
        dismissModal()
    }
    
    //MARK: - Custom Methods
    private func configureNavigationItem() {
        lazy var dismissButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        lazy var saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "새 연락처"
    }
    
    private func configureTextField() {
        nameTextField.keyboardType = .emailAddress
        nameTextField.delegate = self
        ageTextField.keyboardType = .numberPad
        ageTextField.delegate = self
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.delegate = self
    }
    
    private func checkAgeTextField(age: String) -> Bool {
        guard let ageNumber = Int(age), 0 < ageNumber, ageNumber <= 999 else {
            return false
        }
        return true
    }
    
    private func checkPhoneNumberTextField(for phoneNumber: String) -> Bool {
        let onlyNumber = phoneNumber.extractNumbersFromStrings()
        let regexPattern = "^[0-9]+-[0-9]+-[0-9]+$"
        
        guard checkDigitsOver(number: 9, for: onlyNumber) else {
            print("\(TextFieldError.phoneNumberTextFieldError.errorMessage)")
            presentPhoneNumberAlert()
            return false
        }
        
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            guard regex.firstMatch(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count)) != nil else {
                print("\(TextFieldError.phoneNumberTextFieldError.errorMessage)")
                return false
            }
            return true
        } catch {
            print("\(TextFieldError.phoneNumberTextFieldError.errorMessage)")
            return false
        }
    }
    
    private func checkDigitsOver(number: Int, for phoneNumber: String) -> Bool {
        if phoneNumber.count < number {
            return false
        } else {
            return true
        }
    }
    
    private func removeEmptySpaceCharacter(_ textField: UITextField) -> String? {
        return textField.text?.filter { $0.isWhitespace == false }
    }
    
    private func dismissModal() {
        self.dismiss(animated: true)
    }
    
    //MARK: - Alert 구현
    private func presentNameAlert() {
        presentAlert(title: "\(TextFieldError.nameTextFieldError.errorMessage)", message: "", confirmTitle: "확인")
    }
    
    private func presentAgeAlert() {
        presentAlert(title: "\(TextFieldError.ageTextFieldError.errorMessage)", message: "", confirmTitle: "확인")
    }
    
    private func presentPhoneNumberAlert() {
        presentAlert(title: "\(TextFieldError.phoneNumberTextFieldError.errorMessage)", message: "", confirmTitle: "확인")
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
