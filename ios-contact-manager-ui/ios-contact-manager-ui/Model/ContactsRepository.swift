//
//  ContactsRepository.swift
//  ios-contact-manager-ui
//
//  Created by 장우석 on 1/11/24.
//

import Foundation

protocol ContactsRepository {
    var contactsRepository: Dictionary<Int, Contact> { get }
    
    mutating func create(_ contact: Contact)
    mutating func update(_ contact: Contact)
    mutating func delete(_ contact: Contact)
}
