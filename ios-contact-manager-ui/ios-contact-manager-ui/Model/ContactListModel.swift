//
//  ContactList.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct ContactListModel {
    private var contactList: Dictionary<Int, Contact>
    
    init() {
        self.contactList = [:]
        if let loadedContacts = loadContactsJson() {
            contactList = loadedContacts.reduce(into: [:]) {
                partialResult, contact in
                partialResult[contact.hashValue] = contact
            }
        }
    }
    
    public func sortedContacts() -> Array<Contact> {
        return contactList.sorted(by: { $0.value.name.uppercased() < $1.value.name.uppercased() }).map { $0.value }
    }
    
    mutating public func delete(_ contact: Contact) {
        contactList.removeValue(forKey: contact.hashValue)
    }
    
    mutating public func updateContactList(contact: Contact) {
        contactList[contact.hashValue] = contact
    }
    
    private func loadContactsJson() -> Array<Contact>? {
        guard let fileLocation = Bundle.main.url(forResource: "contacts", withExtension: "json") else {
            return nil
        }
        do {
            let jsonData = try Data(contentsOf: fileLocation)
            let decoder = JSONDecoder()
            let dataFromJson = try decoder.decode([Contact].self, from: jsonData)
            return dataFromJson
        } catch {
            print(error)
            return nil
        }
    }
}
