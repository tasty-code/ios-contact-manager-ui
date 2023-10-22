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
    
    func add(_ contact: Contact) -> ObjectIdentifier {
        contacts.append(contact)
        sortContactsByName()
        
        return contact.id
    }
    
    func update(for id: ObjectIdentifier, name: String, age: String, phoneNumber: String) {
        guard let contact = contacts.first(where: { $0.id == id }) else { return }
        contact.update(name: name, age: age, phoneNumber: phoneNumber)
        sortContactsByName()
    }
    
    func deleteContact(by id: ObjectIdentifier) {
        guard let index = contacts.firstIndex(where: { $0.id == id }) else { return }
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
    
    func fetchIndexOfContact(with id: ObjectIdentifier) -> Int? {
        return contacts.firstIndex { $0.id == id }
    }
    
    func fetchContactsContains(with name: String) -> [Contact] {
        let temp = contacts.filter { $0.name.contains(name) }
        return temp
    }
    
    private func sortContactsByName() {
        contacts.sort { $0.name < $1.name }
    }
}
