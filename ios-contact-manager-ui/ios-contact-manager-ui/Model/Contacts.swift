//
//  Contacts.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

final class Contacts: ContactsManageable, ContactsApproachable {
    private var contactsRepository: Dictionary<Int, Contact> {
        didSet { sorted() }
    }
    private var sortedContacts: Array<Contact>
    
    init() {
        self.contactsRepository = [:]
        self.sortedContacts = []
        if let loadedContacts = loadContactsJson() {
            contactsRepository = loadedContacts.reduce(into: [:]) { partialResult, contact in
                partialResult[contact.hashValue] = contact
            }
        }
        sorted()
    }
    
    public func contacts() -> Array<Contact> {
        return sortedContacts
    }
    
    public func filter(by condition: String) {
        sorted()
        if condition.count == 0 {
            return
        }
        
        let unicodeScalars = condition.decomposedStringWithCompatibilityMapping.unicodeScalars
        
        if condition.count == unicodeScalars.count {
            sortedContacts = sortedContacts.filter { contact in
                return contact.name.contains(initial: unicodeScalars)
            }
            return
        }
        
        sortedContacts = sortedContacts.filter { contact in
            return contact.name.contains(subCharacter: unicodeScalars)
        }
    }
    
    public func create(_ contact: Contact) {
        contactsRepository[contact.hashValue] = contact
    }
    
    public func update(_ contact: Contact?) {
        contactsRepository[contact.hashValue] = contact
    }
    
    public func delete(_ hashValue: Int) {
        contactsRepository.removeValue(forKey: hashValue)
    }
    
    private func sorted() {
        sortedContacts = contactsRepository.sorted(by: { $0.value.name.uppercased() < $1.value.name.uppercased() }).map { $0.value }
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
