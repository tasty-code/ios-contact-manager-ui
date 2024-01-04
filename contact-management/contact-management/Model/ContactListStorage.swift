//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    
    private var contactList: [ContactList]
    
    init() {
        // 이전 저장된 ContactList값을 저장
        self.contactList = [ContactList]()
    }
    
    func showContact(who pos: Int) throws -> ContactList {
        contactList[pos]
    }
    
    func addContact(
        name: String,
        phoneNumber: String,
        age: Int
    ) {
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList.append(addList)
    }
    
    func deleteContact(pos: Int) throws {
        contactList.remove(at: pos)
    }
    
    func changeContact(
        pos: Int,
        name: String,
        phoneNumber: String,
        age: Int
    ) throws {
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList[pos] = addList
    }
    
    func sizeContactList() -> Int {
        return contactList.count
    }
    
}
