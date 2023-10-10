//
//  ContactManager.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation

final class ContactManager {
    private var contactsList: [ContactInfo] = []
    var listOfContact: [ContactInfo] {
        get {
            return contactsList
        } set(newList) {
            contactsList = newList
        }
    }
    
    func getContact(uuid: UUID) -> ContactInfo? {
        guard let contact = contactsList.first(where: { $0.uuid == uuid }) else { return nil }
        return contact
    }

    func checkContactsListCount() -> Int {
        return contactsList.count
    }
    
    func add(contact: ContactInfo) {
        contactsList.append(contact)
    }
    
    func update(contact: ContactInfo, of uuid: UUID) {
        if let targetIndex = contactsList.firstIndex(where: {$0.uuid == uuid}) {
            contactsList[targetIndex] = contact
        }
    }
    
    func delete(uuid: UUID) {
        if let targetIndex = contactsList.firstIndex(where: {$0.uuid == uuid}) {
            contactsList.remove(at: targetIndex)
        }
    }
}

