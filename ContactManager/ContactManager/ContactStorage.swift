//
//  ContactStorage.swift
//  ContactManager
//
//  Created by MAC2020 on 2024/01/04.
//

import Foundation

class ContactStorage {
    
    private var contactStorage: [Contact] = []
    
    func addContact(newName: String, newAge: Int, newPhoneNumber: String) {
        contactStorage.append(Contact(name: newName, age: newAge, phoneNumber: newPhoneNumber))
    }
    
    func deleteContact(index: Int) {
        contactStorage.remove(at: index)
    }
}
