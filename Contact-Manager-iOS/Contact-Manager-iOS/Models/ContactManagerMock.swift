//
//  ContactManagerMock.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/5/24.
//

class ContactManagerMock: ContactManager {
    
    // MARK: - Property
    private var contactList: [Contact] = [
        Contact(name: "둘리", age: "15", contactNumber: "010-1234-1234"),
        Contact(name: "길동", age: "30", contactNumber: "010-5678-5678"),
        Contact(name: "도우너", age: "14", contactNumber: "010-1234-5678"),
        Contact(name: "또치", age: "16", contactNumber: "010-9874-5612"),
    ]
    
    
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
