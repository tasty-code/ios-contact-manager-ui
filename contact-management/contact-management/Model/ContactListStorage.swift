//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    
    private var contactList: [ContactList] = [ContactList]()
    
    func showContact(who pos: Int) -> ContactList {
        self.contactList[pos]
    }
    
    func addContact(_ contacts: ContactList) {
        self.contactList.append(contacts)
    }
    
    func deleteContact(pos: Int) {
        self.contactList.remove(at: pos)
    }
    
    func changeContact(_ pos: Int, contacts: ContactList) {
        self.contactList[pos] = contacts
    }
    
    func countContactList() -> Int {
        return self.contactList.count
    }
    
}
