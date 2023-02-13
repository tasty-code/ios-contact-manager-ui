//
//  AddContactViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/01.
//

import UIKit

final class AddContactViewController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: UpdateDataProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var ageTextField: UITextField!
    @IBOutlet weak private var phoneNumberTextField: UITextField!
    @IBOutlet weak private var saveButton: UIBarButtonItem!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFirstResponser()
        configureSaveButton()
        setDelegate()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction private func tappedCancelButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "아니오", style: .default)
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    @IBAction private func tappedSaveButton(_ sender: UIBarButtonItem) {
        do {
            guard let name = nameTextField.text else { throw Errors.wrongName }
            guard let age = ageTextField.text else { throw Errors.wrongAge }
            guard let phoneNumber = phoneNumberTextField.text else { throw Errors.wrongPhoneNumber }
            
            let trimmedName = name.split(separator: " ").joined()
            let userInputModel = UserInputModel(name: trimmedName, age: age, phoneNum: phoneNumber)
            
            try delegate?.delevaryupdatedData(userInputModel)
            self.dismiss(animated: true)
            
        } catch {
            presentErrorAlert(with: error.localizedDescription)
        }
    }
}

// MARK: - Methods

extension AddContactViewController {
    
    private func setUpFirstResponser() {
        nameTextField.becomeFirstResponder()
    }
    
    private func configureSaveButton() {
        saveButton.isEnabled = false
    }
    
    private func setDelegate() {
        nameTextField.delegate = self
        ageTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
    
    private func presentErrorAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "예", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    private func checkSaveButtonState() {
        guard let name = nameTextField.text,
              let age = ageTextField.text,
              let phoneNumber = phoneNumberTextField.text else { return }
        
        saveButton.isEnabled = !(name.isEmpty || age.isEmpty || phoneNumber.isEmpty)
    }
    
    private func formmatingPhoneNumber(with number: String?) -> String? {
        guard let number = number else { return nil }
        
        let numberWithNoHyphen = number.split(separator: "-").joined()
        var phoneNumber = numberWithNoHyphen.map { String($0) }
        
        switch phoneNumber.count {
        case 0..<3:
            return phoneNumber.joined()
        case 3..<6:
            phoneNumber.insert("-", at: 2)
            return phoneNumber.joined()
        case 6..<10:
            phoneNumber.insert("-", at: 2)
            phoneNumber.insert("-", at: 6)
            return phoneNumber.joined()
        default:
            phoneNumber.insert("-", at: 3)
            phoneNumber.insert("-", at: 8)
            return phoneNumber.joined()
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if textField == phoneNumberTextField {
            guard let formattedPhoneNumber = formmatingPhoneNumber(with: text) else { return }
            textField.text = formattedPhoneNumber
        }
        checkMaxLength(phoneNumberTextField, 13)
        checkSaveButtonState()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case ageTextField, phoneNumberTextField:
            if string == "" {
                return true
            } else if Int(string) == nil {
                return false
            }
            return true
        default:
            return true
        }
    }
    
    private func checkMaxLength(_ textField: UITextField, _ maxLength: Int) {
        if textField.text!.count > maxLength {
            textField.deleteBackward()
        }
    }
    
}
