//
//  contacts.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/05.
//

import Foundation

class AddressBook {
    
    private var contacts = [Contact]()

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
        return contacts[row]
    }                       
    
    func getRowSize() -> Int {
        return contacts.count
    }
}
