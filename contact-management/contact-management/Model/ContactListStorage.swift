//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    
    private var contactList: [String: ContactList]
    private var accessContact: [Int: String]
    
    private var contactListCnt: Int
    
    init() {
        // 이전 저장된 ContactList값을 저장
        contactListCnt = 0
        self.accessContact = [Int: String]()
        self.contactList = [String: ContactList]()
    }
    
    func showContact(who name: String) throws -> ContactList {
        guard let newList: ContactList = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        return newList
    }
    
    func addContact(
        name: String,
        phoneNumber: String,
        age: Int
    ) {
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList[name] = addList
        accessContact[contactListCnt] = name
        contactListCnt += 1
    }
    
    func deleteContact(name: String) throws {
        guard let _ = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        contactList[name] = nil
    }
    
    func changeContact(
        name: String,
        phoneNumber: String,
        age: Int
    ) throws {
        guard let _ = contactList[name] else {
            throw ContactListError.ContactListNotFound
        }
        let addList = ContactList(name: name, phoneNumber: phoneNumber, age: age)
        contactList[name] = addList
    }
    
    func accessContactList(pos: Int) -> String? {
        return accessContact[pos]
    }
    
    func sizeContactList() -> Int {
        return contactList.count
    }
    
}
