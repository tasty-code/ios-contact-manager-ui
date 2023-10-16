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
            try checkNameTextFieldIsValid()
            try checkAgeTextFieldIsValid()
            try checkPhoneNumberTextFieldIsValid()
            self.saveContact()
            guard let contact = contact else { return }
            self.dismiss(animated: true) {
                super.delegate?.updateContact(contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
 
    override func saveContact() {
        guard let name = super.name,
              let age = super.age,
              let phoneNumber = super.phoneNumber,
              let index = super.contact?.index
        else { return }
        super.contact = Contact(name: name, age: age, phoneNumber: phoneNumber, index: index)
    }

}
