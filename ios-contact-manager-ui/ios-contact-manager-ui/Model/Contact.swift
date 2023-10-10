//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation

typealias PhoneNumber = String

struct Contact: Hashable {
    let uuid: UUID
    private(set) var name: String
    private(set) var age: Int
    private(set) var phoneNumber: PhoneNumber
    
    init(uuid: UUID, name: String, age: Int, phoneNumber: PhoneNumber) {
        self.uuid = uuid
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
    init(uuidString: String, name: String, age: Int, phoneNumber: PhoneNumber) {
        if let uuid = UUID(uuidString: uuidString) {
            self.uuid = uuid
        } else {
            self.uuid = UUID()
        }
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
    init(name: String, age: Int, phoneNumber: PhoneNumber) {
        self.init(uuid: UUID(), name: name, age: age, phoneNumber: phoneNumber)
    }
}
