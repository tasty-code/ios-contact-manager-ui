//
//  ContactEditViewController.swift
//  ios-contact-manager
//
//  Created by 최승범 on 2023/10/16.
//

import UIKit

final class ContactEditViewController: ContactFormViewController {
    private let temporaryContainer: TemporaryContainer
    
    init?(coder: NSCoder, contact: Contact) {
        self.temporaryContainer = TemporaryContainer(contact: contact)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Edit View Controller 생성 실패")
    }
    
    override func configureViewComponents() {
        guard let contact = self.temporaryContainer.contact else { return }
        self.nameTextField.text = contact.name
        self.ageTextField.text = "\(contact.age)"
        self.phoneNumberTextField.text = contact.phoneNumber
        super.configureViewComponents()
    }
    override func touchSaveBarButton(_ sender: UIBarButtonItem) {
        let name = self.nameTextField.text
        let age = self.ageTextField.text
        let phoneNumber = self.phoneNumberTextField.text
        
        do {
            try self.temporaryContainer.formatContact(name, age, phoneNumber)
            guard let contact = self.temporaryContainer.contact else { return }
            self.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.updateContact(self, contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}
