//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    private var contactList: [ContactList]
    
    init(contactList: [ContactList]) {
        self.contactList = contactList
    }
    
    func getContact(_ index: Int) -> ContactList {
        self.contactList[index]
    }
    
    func getContactList() -> [ContactList] {
        self.contactList
    }
    
    func addContact(_ contacts: ContactList) {
        self.contactList.append(contacts)
    }
    
    func deleteContact(_ index: Int) {
        self.contactList.remove(at: index)
    }
    
    func changeContact(_ index: Int, _ contacts: ContactList) {
        self.contactList[index] = contacts
    }
    
    func countContactList() -> Int {
        return self.contactList.count
    }
}
