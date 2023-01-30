//
//  ContactManager.swift
//  ContactManager
//
//  Created by 신동오 on 2022/12/29.
//

import Foundation

final class ContactManager {
    static let shared = ContactManager()
    private var contacts: Set<Contact> = []
    
    private init() { }
    
    func add(contact: Contact) {
        let isInserted = contacts.insert(contact).inserted
        if isInserted {
            print(contact.descriptionForAddContact)
        } else {
            print(InfoMessage.contactAlreadyExists)
        }
    }
    
    func displayContacts() {
        guard contacts.isEmpty == false else {
            return print(InfoMessage.emptyContact)
        }
        
        let sortedContacts = contacts.sorted { $0.name < $1.name }
        sortedContacts.forEach { print($0.description) }
    }

    func searchContact(by name: String) -> Set<Contact>? {
        let searchedContact = contacts.filter {
            $0.isNameContaining(keyword: name)
        }

        guard searchedContact.isEmpty == false else {
            print(InfoMessage.noSearchedContact(for: name))
            return nil
        }

        return searchedContact
    }
}
