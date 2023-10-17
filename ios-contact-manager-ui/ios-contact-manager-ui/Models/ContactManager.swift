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
    
    func addContact(_ contact: Contact) -> ObjectIdentifier {
        contacts.append(contact)
        sortContactsByName()
        
        return contact.id
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
    
    func fetchIndexOfContact(with id: ObjectIdentifier) -> Int? {
        return contacts.firstIndex { $0.id == id }
    }
    
    private func sortContactsByName() {
        contacts.sort { $0.name < $1.name }
    }
}
