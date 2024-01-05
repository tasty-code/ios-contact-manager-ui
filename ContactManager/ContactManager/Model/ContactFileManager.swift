//
//  ContactFileManager.swift
//  ContactManager
//
//  Created by 유니 & L on 1/5/24.
//

import UIKit

final class ContactFileManager {
    
    var contacts: [Contact] = []
    
    func loadJson() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "contact") else {
            print(ContactManagerError.fileNotFound.errorDescription)
            return
        }
        do {
            self.contacts = try jsonDecoder.decode([Contact].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
    
    func insertContact(contact: Contact) {
        contacts.append(contact)
    }
    
    func removeContact(_ indexInt: Int) {
        contacts.remove(at: indexInt)
    }
    
    func updateContact(_ indexInt: Int, _ newContact: Contact) {
        guard indexInt >= 0 && indexInt < contacts.count else {
            print(ContactManagerError.indexNotFound.errorDescription)
            return
        }
        contacts[indexInt] = newContact
    }
}

