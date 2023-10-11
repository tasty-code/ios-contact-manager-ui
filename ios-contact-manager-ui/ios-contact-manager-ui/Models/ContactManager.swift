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
    
    func addContact(_ contact: Contact) {
        contacts.append(contact)
        sortContactsByName()
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
    
    private func sortContactsByName() {
        contacts.sort { $0.name < $1.name }
    }
}
