//
//  ContactManager.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation
import UIKit

final class ContactManager {
    private var contactList: [ContactInfo] = []
    
    func getContact(uuid: UUID) -> ContactInfo? {
        guard let contact = contactList.first(where: { $0.uuid == uuid }) else { return nil }
        return contact
    }
    
    func getContactList() -> [ContactInfo] {
        return contactList
    }
    
    func addContact(name:String, age: Int, phoneNum: String) {
        contactList.append(ContactInfo(name: name, age: age, phoneNum: phoneNum))
    }
    
    func updateContact(name:String, age: Int, phoneNum: String, uuid: UUID) {
        if let targetIndex = contactList.firstIndex(where: {$0.uuid == uuid}) {
            contactList[targetIndex].name = name
            contactList[targetIndex].age = age
            contactList[targetIndex].phoneNum = phoneNum
        }
    }
    
    func deleteContact(uuid: UUID) {
        if let targetIndex = contactList.firstIndex(where: {$0.uuid == uuid}) {
            contactList.remove(at: targetIndex)
        }
    }
}

