//
//  ContactList.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct ContactListModel: ContactsRepository {
    
    var contactsRepository: Dictionary<Int, Contact>
    
    init() {
        self.contactsRepository = [:]
        if let loadedContacts = loadContactsJson() {
            contactsRepository = loadedContacts.reduce(into: [:]) {
                partialResult, contact in
                partialResult[contact.hashValue] = contact
            }
        }
    }
    
    public func sortedContacts() -> Array<Contact> {
        return contactsRepository.sorted(by: { $0.value.name.uppercased() < $1.value.name.uppercased() }).map { $0.value }
    }
    
    mutating public func create(_ contact: Contact) {
        contactsRepository[contact.hashValue] = contact
    }
    
    mutating public func delete(_ contact: Contact) {
        contactsRepository.removeValue(forKey: contact.hashValue)
    }
    
    mutating public func update(_ contact: Contact) {
        contactsRepository[contact.hashValue] = contact
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
