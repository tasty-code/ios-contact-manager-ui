//
//  ContactFileManager.swift
//  ContactManager
//
//  Created by 윤진영 on 1/5/24.
//

import UIKit

final class ContactFileManager {
    
    var contacts: [Contact] = []
    
    func loadJson() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "contact") else {
            print("File Not Found Error")
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
    
    func updateContact(indexInt: Int, newContact: Contact) {
        guard indexInt >= 0 && indexInt < contacts.count else {
            print("해당 인덱스를 찾을 수 없습니다.")
            return
        }
        contacts[indexInt] = newContact
    }
    
}
