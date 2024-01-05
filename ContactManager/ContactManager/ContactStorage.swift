//
//  ContactStorage.swift
//  ContactManager
//
//  Created by MAC2020 on 2024/01/04.
//

import Foundation

class ContactStorage {
    
    private var contactStorage: [Contact] = []
    
    var contacteCount: Int {
        return contactStorage.count
    }
    
    func initalContact(contactData: [Contact]) {
        contactStorage = contactData
    }
    
    func fetchContact(index: Int) -> Contact {
        return contactStorage[index]
    }
    
    func addContact(newName: String, newAge: Int, newPhoneNumber: String) {
        contactStorage.append(Contact(name: newName, age: newAge, phoneNumber: newPhoneNumber))
    }
    
    func deleteContact(index: Int) {
        contactStorage.remove(at: index)
    }
}
