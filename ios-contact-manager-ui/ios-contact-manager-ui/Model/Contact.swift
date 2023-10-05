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
    private(set) var phoneNumbers = Set<PhoneNumber>()
    
    fileprivate mutating func changeName(_ name: String) {
        self.name = name
    }
    
    fileprivate mutating func changeAge(_ age: Int) {
        self.age = age
    }
    
    fileprivate mutating func add(_ phoneNumber: PhoneNumber) {
        phoneNumbers.insert(phoneNumber)
    }
    
    fileprivate mutating func delete(_ phoneNumber: PhoneNumber) {
        phoneNumbers.remove(phoneNumber)
    }
    
    fileprivate mutating func modify(from existingPhoneNumber: PhoneNumber, to newPhoneNumber: PhoneNumber) {
        phoneNumbers.remove(existingPhoneNumber)
        phoneNumbers.insert(newPhoneNumber)
    }
}



//MARK: - ContactManager
class ContactManager {
    private(set) var contacts = [UUID: Contact]()
    
    func add(_ person: Contact) throws {
        if contacts[person.uuid] != nil {
            throw ContactException.contactAlreadyExsist(contact: person)
        }
        contacts[person.uuid] = person
    }
    
    func add(_ phoneNumber: PhoneNumber, of uuid: UUID) {
        contacts[uuid]?.add(phoneNumber)
    }
    
    func delete(_ person: Contact) throws {
        guard let _ = contacts.removeValue(forKey: person.uuid)
        else {
            throw ContactException.contactNotFound(contact: person)
        }
    }
    
    func delete(_ phoneNumber: PhoneNumber, of uuid: UUID) {
        contacts[uuid]?.delete(phoneNumber)
    }
    
    func modify(_ personName: String, _ personAge: Int, of person: Contact) throws {
        guard var contact = contacts[person.uuid]
        else {
            throw ContactException.contactNotFound(contact: person)
        }
        contact.changeName(personName)
        contact.changeAge(personAge)
        contacts[person.uuid] = contact
    }
    
    func modify(from exsistingPhoneNumber: PhoneNumber, to newPhoneNumber: PhoneNumber, of uuid: UUID) {
        contacts[uuid]?.modify(from: exsistingPhoneNumber, to: newPhoneNumber)
    }
}
