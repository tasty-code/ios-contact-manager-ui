//
//  ContactList.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

final class ContactList {
    typealias Index = Int
    
    private var contacts: [Contact]
    
    init(contacts: [Contact] = []) {
        self.contacts = contacts
    }
    
    func getContact(id: Int) throws -> Contact {
        guard let contact = self.contacts.first(where: { contact in contact.id == id }) else {
            throw ContactListError.invalidID
        }
        return contact
    }
    
    func getContacts() -> [Contact] {
        return self.contacts
    }
    
    func addContacts(_ newContacts: [Contact]) {
        self.contacts.append(contentsOf: newContacts)
    }
    
    func addContact(_ newContact: Contact) {
        self.contacts.insert(newContact, at: 0)
    }
    
    func deleteContact(contactID: Int) throws {
        let index = try getIndexofContact(id: contactID)
        self.contacts.remove(at: index)
    }
    
    func updateContact(with newContact: Contact) throws {
        let index = try getIndexofContact(id: newContact.id)
        self.contacts[index] = newContact
    }
}

extension ContactList {
    private func getIndexofContact(id: Int) throws -> Index {
        guard let index = self.contacts.firstIndex(where: { contact in contact.id == id }) else {
            throw ContactListError.invalidID
        }
        return index
    }
}
