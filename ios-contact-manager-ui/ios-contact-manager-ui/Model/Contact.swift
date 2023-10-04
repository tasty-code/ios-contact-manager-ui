//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation

typealias PhoneNumber = String

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
