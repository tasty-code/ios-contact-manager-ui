//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by dopamint on 1/2/24.
//

import UIKit

final class ContactManager {
    private var contacts: [Contact]
    
    var contactsCount: Int {
        return contacts.count
    }
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
    
    func contact(row: Int) -> Contact {
        return contacts[row]
    }
    
    func loadData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard
            let dataAsset: NSDataAsset = NSDataAsset(name: "contacts")
        else {
            return
        }
        do {
            contacts = try jsonDecoder.decode([Contact].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addContact(contact: Contact) {
        contacts.append(contact)
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func editContact(contact: Contact) {
        let contactIndices = contacts.indices
        let indexOfContactToBeEdited = contactIndices.filter { contacts[$0].id == contact.id }
        indexOfContactToBeEdited.forEach { contacts[$0] = contact }
    }
}
