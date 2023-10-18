//
//  ContactManager.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation

final class ContactManager {
    private(set) var contactsList: [ContactInfo] = []
    var countOfContactList: Int {
        return contactsList.count
    }
    
    func setContactsList(_ list: [ContactInfo]) {
        contactsList = list
    }
    
    func getContact(of uuid: UUID) -> ContactInfo? {
        guard let contact = contactsList.first(where: { $0.uuid == uuid }) else { return nil }
        return contact
    }
}

extension ContactManager {
    func add(_ contact: ContactInfo) {
        contactsList.append(contact)
    }
    
    func update(_ contact: ContactInfo, of uuid: UUID) {
        if let targetIndex = contactsList.firstIndex(where: {$0.uuid == uuid}) {
            contactsList[targetIndex] = contact
        }
    }
    
    func delete(_ uuid: UUID) {
        if let targetIndex = contactsList.firstIndex(where: {$0.uuid == uuid}) {
            contactsList.remove(at: targetIndex)
        }
    }
}
