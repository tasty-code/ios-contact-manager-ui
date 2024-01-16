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
            print(error.localizedDescription)
        }
    }
    
    func addContact(contact: Contact) {
        contacts.append(contact)
    }
    
    func removeContact(_ index: Int) {
        contacts.remove(at: index)
    }
    
    func updateContact(_ id: String, _ newContact: Contact) {
        guard let index = contacts.firstIndex(where: { $0.id == id }) else {
            print(ContactManagerError.indexNotFound.errorDescription)
            return
        }
        contacts[index] = newContact
    }
}

