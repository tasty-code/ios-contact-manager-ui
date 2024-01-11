//
//  ContactsRepository.swift
//  ios-contact-manager-ui
//
//  Created by 장우석 on 1/11/24.
//

import Foundation

protocol ContactsRepository {
    mutating func create(_ contact: Contact)
    mutating func update(_ contact: Contact)
    mutating func delete(_ contact: Contact)
}

protocol ContactsViewer {
//    var contactsRepository: Dictionary<Int, Contact> { get }
    
    func sortedContacts() -> Array<Contact>
}
