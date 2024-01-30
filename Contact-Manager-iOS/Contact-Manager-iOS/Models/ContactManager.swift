//
//  ContactManager.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//
final class ContactManager {
    
    // MARK: - Property
    private var contactList: [Contact] = []
    
    
    // MARK: - Method
    func makeMockContactListData() {
        contactList = [
            Contact(name: "둘리", age: "15", contactNumber: "010-1234-1234"),
            Contact(name: "길동", age: "30", contactNumber: "010-5678-5678"),
            Contact(name: "도우너", age: "14", contactNumber: "010-1234-5678"),
            Contact(name: "또치", age: "16", contactNumber: "010-9874-5612"),
        ]
    }
    
    func fetchAllContacts() -> [Contact] {
        return contactList
    }
    
    func addNewContact(contact: Contact) {
        contactList.append(contact)
    }
    
    func deleteContact(contactId id: Int) {
        if let index = contactList.firstIndex(where: { $0.id == id }) {
            contactList.remove(at: index)
        }
    }
    
    func updateContact(contactId id: Int, with updateContact: Contact) {
        if let index = contactList.firstIndex(where: { $0.id == id }) {
            contactList[index] = updateContact
        }
    }
}
