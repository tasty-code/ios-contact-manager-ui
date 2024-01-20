//
//  ContactRepository.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import Foundation

protocol ContactRepository {
    func requestContact(id: Int) throws -> Contact
    
    func requestContacts() throws -> [Contact]
    
    func addContact(_ newContact: Contact) throws
    
    func removeContact(at index: Int) throws
    
    func searchContact(with queries: [String]) throws -> [Contact]
    
    func updateContact(with updatedContact: Contact) throws
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
    
    func requestContact(id: Int) throws -> Contact {
        do {
            return try self.contactList.getContact(id: id)
        } catch ContactListError.invalidID {
            throw ContactRepositoryError.notFound
        }
    }
    
    func requestContacts() throws -> [Contact] {
        let contacts = self.contactList.getContacts()
        guard contacts.isEmpty == false else { throw ContactRepositoryError.noContacts }
        return contacts
    }
    
    func addContact(_ newContact: Contact) throws {
        self.contactList.addContact(newContact)
    }
    
    func removeContact(at index: Int) throws {
        do {
            try self.contactList.deleteContact(at: index)
        } catch ContactListError.invalidIndex {
            throw ContactRepositoryError.cannotRemove
        } catch {
            throw error
        }
    }
    
    func searchContact(with queries: [String]) throws -> [Contact] {
        let contacts = self.contactList.getContacts()
        var matches = contacts
        for query in queries {
            matches = matches.filter { contact in self.match(query, to: contact) }
        }
        guard matches.isEmpty == false else { throw ContactRepositoryError.noSearchingResult }
        return matches
    }
    
    func updateContact(with updatedContact: Contact) throws {
        do {
            try self.contactList.updateContact(with: updatedContact)
        } catch {
            throw ContactRepositoryError.cannotUpdate
        }
    }
    
    private func match(_ query: String, to contact: Contact) -> Bool {
        // 이름에 쿼리가 포함되는지 확인
        var result = contact.name.localizedCaseInsensitiveContains(query)
        
        // 숫자로 바꿀 수 있는 쿼리라면 나이와 같은지 확인
        if let number = Int(query) {
            result = result || (contact.age == number)
        }
        
        // 하이픈을 제외한 전화번호와 일치하는 부분이 있는지
        let purePhoneNumberString = contact.phoneNumber.filter { ch in ch.isNumber }
        result = result || (purePhoneNumberString.localizedStandardContains(query))
        
        return result
    }
}

extension ContactRepositoryImpl {
    private func getContactsFromBundle() throws -> Data {
        let fileName = "contacts"
        return try fileProvider.getData(from: fileName, extension: FileExtension.json)
    }
}
