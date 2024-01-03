//
//  ContactList.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct ContactList {
    private var contactList: Dictionary<String, Contact>
    
    init() {
        self.contactList = [:]
    }
    
    public func showContactList() -> Array<Contact> {
        return contactList.sorted(by: { $0.value.name > $1.value.name }).map { $0.value }
    }
    
    mutating public func addContact(contact: Contact) {
        contactList[contact.contact] = contact
    }
    
    mutating public func deleteContact(contact: Contact) {
        contactList.removeValue(forKey: contact.contact)
    }
    
    mutating public func updateContact(contact: Contact) {
        contactList[contact.contact] = contact
    }
}
