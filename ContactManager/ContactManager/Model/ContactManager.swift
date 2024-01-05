//
//  ContactStorage.swift
//  ContactManager
//
//  Created by MAC2020 on 2024/01/04.
//

import Foundation

class ContactMananger {
    
    private var storage: [Contact] = []
    
    var contacteCount: Int {
        return storage.count
    }
    
    func initalContact(contactData: [Contact]) {
        storage = contactData
    }
    
    func fetchContact(index: Int) -> Contact {
        return storage[index]
    }
    
    func addContact(newName: String, newAge: Int, newPhoneNumber: String) {
        storage.append(Contact(name: newName, age: newAge, phoneNumber: newPhoneNumber))
    }
    
    func deleteContact(index: Int) {
        storage.remove(at: index)
    }
}
