//
//  ContactManager.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation

final class ContactManager {
    private var contactList: [ContactInfo] = []
    
    func getContact() {

    }
    
    func getContactList() -> [ContactInfo] {
        return contactList
    }
    
    func addContact(name:String, age: Int, phoneNum: String) {
        contactList.append(ContactInfo(name: name, age: age, phoneNum: phoneNum))
    }
    
    func updateContact() {
        
    }
    
    func deleteContact() {}
    
}
