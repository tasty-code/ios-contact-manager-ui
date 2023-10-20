//
//  contacts.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/05.
//

import Foundation

class AddressBook {
    
    private var contacts = [Contact]()
    private var filteredContacts: [Contact]?
    private var searchText: String?
    
    func addContact(_ newContact: Contact) {
        contacts.append(newContact)
        contacts.sort(by: {$0.name < $1.name})
    }
    
    func deleteContact(_ row: Int) {
        contacts.remove(at: row)
    }
    
    func changeContact(_ row: Int, _ changedContact: Contact) {
        contacts[row] = changedContact
    }
    
    func showContact(_ row: Int) -> Contact {
        guard let input = searchText, let filtered = filteredContacts else {
            return contacts[row]
        }
        
        if filtered.isEmpty && input.isEmpty {
            return contacts[row]
        }
        
        if !input.isEmpty {
            return filtered[row]
        }
        
        return contacts[row]
    }
    
    func getRowSize() -> Int {
        
        guard let input = searchText, let filtered = filteredContacts else {
            return contacts.count
        }
        
        if filtered.isEmpty && input.isEmpty {
            return contacts.count
        }
        
        if !input.isEmpty {
            return filtered.count
        }
        
        return contacts.count
    }
    
    func searchContact(_ input: String) {
        searchText = input
        filteredContacts = []
        
        for contact in contacts {
            if contact.name.lowercased().contains(input.lowercased()) {
                filteredContacts?.append(contact)
            }
        }
        
        for contact in contacts {
            if contact.phoneNumber.replacingOccurrences(of: "-", with: "").contains(input.replacingOccurrences(of: "-", with: "")){
                filteredContacts?.append(contact)
            }
        }
    }
}
