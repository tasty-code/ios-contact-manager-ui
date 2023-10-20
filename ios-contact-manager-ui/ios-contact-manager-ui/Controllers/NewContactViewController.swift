//
//  NewContactViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/10.
//

import UIKit

protocol ContactsTableViewUpdateDelegate: AnyObject {
    func didContactsAdded(_ contactId: ObjectIdentifier)
    func didContactsChanged(_ contactId: ObjectIdentifier)
}

final class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    private var contactManager: ContactManager?
    private weak var delegate: ContactsTableViewUpdateDelegate?
    var contact: Contact?
    private let hyphen: Character = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        nameTextField.autocapitalizationType = .sentences
        ageTextField.keyboardType = .numberPad
        phoneNumberTextField.keyboardType = .phonePad
        
        if let contact = contact {
            nameTextField.text = contact.name
            ageTextField.text = contact.age
            phoneNumberTextField.text = contact.phoneNumber
        }
    }
    
    @IBAction func phoneNumberTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text?.replacingOccurrences(of: "\(hyphen)", with: "") else { return }
        sender.text = text.formattingPhoneNumber(divider: hyphen)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let alertKind = AlertKind.cancel(
            title: "정말로 취소하시겠습니까?",
            actions: [
                UIAlertAction(title: "예", style: .destructive, handler: { _ in
                    self.dismiss(animated: true)
                }),
                UIAlertAction(title: "아니오", style: .cancel)
            ]
        )
        present(alertKind.configureAlertController(), animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let contactManager = contactManager else { return }
        do {
            let (name, age, phoneNumber) = try makeCheckedInfo()
            if let contact = self.contact {
                contactManager.update(for: contact.id, name: name, age: age, phoneNumber: phoneNumber)
                delegate?.didContactsChanged(contact.id)
            } else {
                let contactId = contactManager.add(Contact(name: name, age: age, phoneNumber: phoneNumber))
                delegate?.didContactsAdded(contactId)
            }
            self.dismiss(animated: true)
        } catch {
            let alertKind = AlertKind.error(type: error, action: UIAlertAction(title: "예", style: .default))
            present(alertKind.configureAlertController(), animated: true)
        }
    }
}

extension NewContactViewController {
    func configureData(_ contactManager: ContactManager?, delegate: ContactsTableViewUpdateDelegate?, contact: Contact? = nil) {
        self.contactManager = contactManager
        self.delegate = delegate
        
        if contact != nil {
            self.navigationItem.title = "기존 연락처"
            self.contact = contact
        }
    }
}

extension NewContactViewController: Validatable {
    private func makeCheckedInfo() throws -> (String, String, String) {
        guard let name = nameTextField.text, verifyName(name) else {
            throw ContactsError.invalidName
        }
        guard let age = ageTextField.text, verifyAge(age) else {
            throw ContactsError.invalidAge
        }
        guard let phoneNumber = phoneNumberTextField.text, verifyNumber(phoneNumber) else {
            throw ContactsError.invalidPhoneNumber
        }
        return (name, age, phoneNumber)
    }
}
