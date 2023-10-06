//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation

typealias PhoneNumber = String

//MARK: - Contact
struct Contact: Hashable {
    let uuid = UUID()
    private(set) var name: String
    private(set) var age: Int
    private var _phoneNumbers = Set<PhoneNumber>()
    var phoneNumbers: [PhoneNumber] {
        _phoneNumbers.sorted()
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    fileprivate mutating func changeName(_ name: String) {
        self.name = name
    }
    
    fileprivate mutating func changeAge(_ age: Int) {
        self.age = age
    }
    
    fileprivate mutating func add(_ phoneNumber: PhoneNumber) {
        _phoneNumbers.insert(phoneNumber)
    }
    
    fileprivate mutating func delete(_ phoneNumber: PhoneNumber) {
        _phoneNumbers.remove(phoneNumber)
    }
    
    fileprivate mutating func modify(from existingPhoneNumber: PhoneNumber, to newPhoneNumber: PhoneNumber) {
        _phoneNumbers.remove(existingPhoneNumber)
        _phoneNumbers.insert(newPhoneNumber)
    }
}



//MARK: - ContactManager
class ContactManager {
    private(set) var _contacts = [UUID: Contact]()
    var contacts: [Contact] {
        _contacts.values.sorted { $0.name < $1.name }
    }
    
    func add(_ person: Contact) throws {
        if _contacts[person.uuid] != nil {
            throw ContactException.contactAlreadyExsist(contact: person)
        }
        _contacts[person.uuid] = person
    }
    
    func add(_ phoneNumber: PhoneNumber, of uuid: UUID) {
        _contacts[uuid]?.add(phoneNumber)
    }
    
    func delete(_ person: Contact) throws {
        guard let _ = _contacts.removeValue(forKey: person.uuid)
        else {
            throw ContactException.contactNotFound(contact: person)
        }
    }
    
    func delete(_ phoneNumber: PhoneNumber, of uuid: UUID) {
        _contacts[uuid]?.delete(phoneNumber)
    }
    
    func modify(_ personName: String, _ personAge: Int, of person: Contact) throws {
        guard var contact = _contacts[person.uuid]
        else {
            throw ContactException.contactNotFound(contact: person)
        }
        contact.changeName(personName)
        contact.changeAge(personAge)
        _contacts[person.uuid] = contact
    }
    
    func modify(from exsistingPhoneNumber: PhoneNumber, to newPhoneNumber: PhoneNumber, of uuid: UUID) {
        _contacts[uuid]?.modify(from: exsistingPhoneNumber, to: newPhoneNumber)
    }
}
