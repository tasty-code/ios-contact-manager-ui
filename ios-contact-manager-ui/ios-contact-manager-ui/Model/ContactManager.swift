//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/10.
//

import Foundation

class ContactManager {
    private var _contacts = [UUID: Contact]()
    var contacts: [Contact] {
        _contacts.values.sorted { $0.name < $1.name }
    }
    
    func add(_ contact: Contact) throws {
        if _contacts[contact.uuid] != nil {
            throw ContactException.contactAlreadyExsist(contact: contact)
        }
        _contacts[contact.uuid] = contact
    }
    
    func delete(_ person: Contact) throws {
        guard let _ = _contacts.removeValue(forKey: person.uuid)
        else {
            throw ContactException.contactNotFound(contact: person)
        }
    }
    
    func modify(_ oldContact: Contact, to newContact: Contact) throws {
        if _contacts[oldContact.uuid] == nil {
            throw ContactException.contactNotFound(contact: oldContact)
        }
        _contacts.removeValue(forKey: oldContact.uuid)
        _contacts[newContact.uuid] = newContact
    }
}
