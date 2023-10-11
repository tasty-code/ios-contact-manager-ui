//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/10.
//

import Foundation

final class ContactManager {
    private static var _contacts = [UUID: Contact]()
    var contacts: [Contact] {
        ContactManager._contacts.values.sorted { $0.name < $1.name }
    }
    
    func add(_ contact: Contact) throws {
        if ContactManager._contacts[contact.uuid] != nil {
            throw ContactException.contactAlreadyExsist(contact: contact)
        }
        ContactManager._contacts[contact.uuid] = contact
    }
    
    func delete(_ contact: Contact) throws {
        guard let _ = ContactManager._contacts.removeValue(forKey: contact.uuid)
        else {
            throw ContactException.contactNotFound(contact: contact)
        }
    }
    
    func modify(_ oldContact: Contact, to newContact: Contact) throws {
        if ContactManager._contacts[oldContact.uuid] == nil {
            throw ContactException.contactNotFound(contact: oldContact)
        }
        ContactManager._contacts.removeValue(forKey: oldContact.uuid)
        ContactManager._contacts[newContact.uuid] = newContact
    }
}
