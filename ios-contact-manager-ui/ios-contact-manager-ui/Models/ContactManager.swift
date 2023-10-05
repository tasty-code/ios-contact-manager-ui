//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class ContactManager {
    private var contacts: [Contact] = []
    
    var contactsCount: Int {
        return contacts.count
    }
    
    func addContact(_ name: String, _ age: Int, _ phoneNumber: String) {
        contacts.append(Contact(name: name, age: age, phoneNumber: phoneNumber))
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
}
