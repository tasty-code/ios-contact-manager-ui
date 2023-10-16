//
//  EditViewController.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import UIKit

class ContactCreateViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    weak var delegate: ContactsManagable?
    var contact: Contact?
    
    init(_ contact: Contact?) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewComponents()
        self.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingChanged), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ textField: UITextField) {
        guard let text = textField.text?.replacingOccurrences(of: "-", with: "") else { return }
        textField.text = text.formatted(by: "-")
    }
    
    func configureViewComponents() {
        self.ageTextField.keyboardType = .numberPad
        self.phoneNumberTextField.keyboardType = .phonePad
    }
    
    private func presentRewindCancelAlert() {
        let alert = UIAlertController(title: "정말로 취소하시겠습니까?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        let noAction = UIAlertAction(title: "아니오", style: .default)
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true)
    }
    
    func presentErrorAlert(_ error: ContactError) {
        let alert = UIAlertController(title: error.description, message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    @IBAction private func touchCancelBarButton(_ sender: UIBarButtonItem) {
        self.presentRewindCancelAlert()
    }
    
    @IBAction func touchSaveBarButton(_ sender: UIBarButtonItem) {
        do {
            let name = try formatNameTextFieldText()
            let age = try formatAgeTextFieldText()
            let phoneNumber = try formatPhoneNumberTextFieldText()
            let contact = Contact(name: name, age: age, phoneNumber: phoneNumber, index: nil)
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.createContact(contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}

// MARK: TextField validation methods
extension ContactCreateViewController {
    func formatNameTextFieldText() throws -> String {
        guard let text = self.nameTextField.text,
              text.isEmpty == false
        else { throw ContactError.invalidName }
        
        return text.replacingOccurrences(of: " ", with: "")
    }
    
    func formatAgeTextFieldText() throws -> Int {
        guard let text = self.ageTextField.text?.replacingOccurrences(of: " ", with: ""),
              let age = Int(text),
              age >= 0 && age < 1000
        else { throw ContactError.invalidAge }
        
        return age
    }
    
    func formatPhoneNumberTextFieldText() throws -> String {
        guard let text = self.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: ""),
              text.count >= 9,
              let _ = Int(text)
        else { throw ContactError.invalidPhoneNumber }
        
        return text.formatted()
    }
}
