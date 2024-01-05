//
//  ContactManager.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//
final class ContactManagerImplement: ContactManager {
    
    // MARK: - Property
    private var contactList: [Contact] = []

    
    // MARK: - Method
    func showUpAllContacts() -> [Contact] {
        return contactList
    }
    
    func addNewContact(contact: Contact) {
        contactList.append(contact)
    }
    
    func deleteContact(at index: Int) {
        guard index >= 0 && index < contactList.count else {
            return
        }
        contactList.remove(at: index)
    }
    
    func updateContact(at index: Int, with updateContact: Contact) {
        guard index >= 0 && index < contactList.count else {
            return
        }
        contactList[index] = updateContact
    }
}
