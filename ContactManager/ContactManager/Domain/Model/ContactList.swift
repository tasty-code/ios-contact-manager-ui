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
    
    func deleteContact(at index: Index) throws {
        guard validateIndex(index) else { throw ContactListError.invalidIndex }
        self.contacts.remove(at: index)
    }
    
    func updateContact(at index: Index, with newContact: Contact) throws {
        guard validateIndex(index) else { throw ContactListError.invalidIndex }
        self.contacts[index] = newContact
    }
}

extension ContactList {
    private func validateIndex(_ index: Index) -> Bool {
        return self.contacts.indices.contains(index)
    }
}
