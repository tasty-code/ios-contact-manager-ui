//
//  ContactEditViewController.swift
//  ios-contact-manager
//
//  Created by 최승범 on 2023/10/16.
//

import UIKit

final class ContactEditViewController: ContactCreateViewController {
    override func configureViewComponents() {
        self.ageTextField.keyboardType = .numberPad
        self.phoneNumberTextField.keyboardType = .phonePad
        
        if let contact = contact {
            super.contact = contact
            self.nameTextField.text = contact.name
            self.ageTextField.text = "\(contact.age)"
            self.phoneNumberTextField.text = contact.phoneNumber
        }
    }
    
    override func touchSaveBarButton(_ sender: UIBarButtonItem) {
        do {
            let name = try formatNameTextFieldText()
            let age = try formatAgeTextFieldText()
            let phoneNumber = try formatPhoneNumberTextFieldText()
            guard let index = super.contact?.index else { return }
            let contact = Contact(name: name, age: age, phoneNumber: phoneNumber, index: index)
            self.dismiss(animated: true) {
                super.delegate?.updateContact(contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}
