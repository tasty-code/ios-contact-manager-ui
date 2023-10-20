//
//  ContactCreateViewController.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/17/23.
//

import UIKit

final class ContactCreateViewController: ContactFormViewController {
    private let temporaryContainer = TemporaryContainer()
    
    override func touchSaveBarButton(_ sender: UIBarButtonItem) {
        let name = self.nameTextField.text
        let age = self.ageTextField.text
        let phoneNumber = self.phoneNumberTextField.text
        
        do {
            try self.temporaryContainer.formatContact(name, age, phoneNumber)
            guard let contact = self.temporaryContainer.contact else { return }
            self.dismiss(animated: true) { [weak self] in
                guard let self = self else { return }
                self.delegate?.createContact(self, contact)
            }
        } catch {
            guard let error = error as? ContactError else { return }
            self.presentErrorAlert(error)
        }
    }
}
