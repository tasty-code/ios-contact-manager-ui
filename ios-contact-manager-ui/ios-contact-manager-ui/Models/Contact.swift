//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class Contact: Codable {
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
    
    private func verifyName(_ name: String) -> Bool {
        let tempName = name.split(separator: " ").map { $0 }.reduce("") { $0 + $1 }
        return !tempName.isEmpty
    }
    
    private func verifyAge(_ age: String) -> Bool {
        let tempAge = age.split(separator: " ").map { $0 }.reduce("") { $0 + $1 }
        let regex = "^([1-9]{1})?([0-9]{1,2})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: tempAge)
    }
    
    private func verifyNumber(_ phoneNumber: String) -> Bool {
        let regex = "^0([0-9]{1,2})-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
}
