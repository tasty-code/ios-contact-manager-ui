//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class Contact: Codable, Validatable {
    var name: String
    var age: String
    var phoneNumber: String
    
    init(name: String, age: String, phoneNumber: String) throws {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
        
        guard verifyName(name) else {
            throw ContactsError.invalidName
        }
        
        guard verifyAge(age) else {
            throw ContactsError.invalidAge
        }
        
        guard verifyNumber(phoneNumber) else {
            throw ContactsError.invalidPhoneNumber
        }
    }
}
