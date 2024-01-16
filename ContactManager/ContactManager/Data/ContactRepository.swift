//
//  ContactRepository.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import Foundation

protocol ContactRepository {
    func requestContacts() throws -> [Contact]
    
    func addContact(_ newContact: Contact) throws
}

struct ContactRepositoryImpl: ContactRepository {
    private let contactList: ContactList
    
    private let fileProvider: FileProvidable
    
    private let jsonDecoder: JSONDecoder = .init()
    
    init(
        contactList: ContactList,
        fileProvider: FileProvidable
    ) {
        self.contactList = contactList
        self.fileProvider = fileProvider
    }
    
    func requestContacts() throws -> [Contact] {
        return self.contactList.getContacts()
    }
    
    func addContact(_ newContact: Contact) throws {
        self.contactList.addContact(newContact)
    }
}

extension ContactRepositoryImpl {
    private func getContactsFromBundle() throws -> Data {
        let fileName = "contacts"
        return try fileProvider.getData(from: fileName, extension: FileExtension.json)
    }
}
