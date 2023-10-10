//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class ContactManager {
    private var contacts: [Contact] = []
    
    var contactsCount: Int {
        return contacts.count
    }
    
    func addContact(_ contact: Contact) throws {
        guard checkDuplicateNumber(contact.phoneNumber) else {
            throw ContactsError.duplicateNumberFound
        }
        contacts.append(contact)
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
    
    private func checkDuplicateNumber(_ phoneNumber: String) -> Bool {
        if contacts.contains(where: { $0.phoneNumber == phoneNumber }) {
            return false
        }
        return true
    }
}
