//
//  contacts.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/05.
//

import Foundation

class AddressBook {
    
    private var contacts: [[Contact]] = Array(repeating: [], count: 27)
    private var contactsForDisplay: [[Contact]] = [[Contact]]()
    
    func getFirstLetterIndex(_ name: String) -> Int {
        let firstLetter = Array(name)[0].uppercased()
        let index = firstLetter.unicodeScalars.map { Int($0.value)}[0]
        return index >= 65 && index <= 90 ? Int(index - 65) : 26
    }
    
    func addContact(_ newContact: Contact) {
        let index = getFirstLetterIndex(newContact.name)
        contacts[index].append(newContact)
        contacts[index].sort(by: {$0.name < $1.name})
    }
    
    func deleteContact(_ section: Int, _ row: Int) {
        contacts[section].remove(at: row)
    }
    
    func changeContact(_ section: Int, _ row: Int, _ changedContact: Contact) {
        contacts[section][row] = changedContact
    }
    
    func showContact(_ section: Int, _ row: Int) -> Contact {
        return contactsForDisplay[section][row]
    }
    
    func getSectionSize() -> Int {
        contactsForDisplay = contacts.filter{ !$0.isEmpty }
        return contactsForDisplay.count
    }
    
    func getRowSize(_ section: Int) -> Int {
        return contactsForDisplay[section].count
    }
}
