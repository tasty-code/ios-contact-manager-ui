//
//  ContactManager.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//
class ContactManagerImpl {
    
    // MARK: - Property
    private var contactList: [Contact] = []

    
    // MARK: - Method
    func showUpAllContacts() -> [Contact] {
        return contactList
    }
    
    func addNewContacts(contact: Contact) {
        contactList.append(contact)
    }
    
    func deleteContact(at index: Int) {
        contactList.remove(at: index)
    }
    
    func updateContact(at index: Int, with updateContact: Contact) {
        contactList[index] = updateContact
    }
}
