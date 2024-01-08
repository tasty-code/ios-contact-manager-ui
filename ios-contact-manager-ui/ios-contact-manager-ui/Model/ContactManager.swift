//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/5/24.
//

import Foundation
import UIKit

final class ContactManager {
    var contacts: [Contact] = []
    
    func add(contact: Contact) {
        contacts.append(contact)
    }
    
    func delete(index: IndexPath) {
        contacts.remove(at: index.row)
    }
    
    func show(index: IndexPath) -> Contact {
        return contacts[index.row]
    }
    
    func modify(contact: Contact, indexPath: IndexPath) {
        contacts[indexPath.row] = contact
    }
}

