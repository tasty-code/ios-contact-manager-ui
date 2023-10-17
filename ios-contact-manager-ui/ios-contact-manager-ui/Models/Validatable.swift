//
//  Validatable.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/10.
//

import Foundation

protocol Validatable {
    func verifyName(_ name: String) -> Bool
    func verifyAge(_ age: String) -> Bool
    func verifyNumber(_ phoneNumber: String) -> Bool
}

extension Validatable {
    func verifyName(_ name: String) -> Bool {
        let tempName = name.split(separator: " ").map { $0 }.reduce("") { $0 + $1 }
        return !tempName.isEmpty
    }
    
    func verifyAge(_ age: String) -> Bool {
        let tempAge = age.split(separator: " ").map { $0 }.reduce("") { $0 + $1 }
        let regex = "^([1-9]{1})?([0-9]{1,2})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: tempAge)
    }
    
    func verifyNumber(_ phoneNumber: String) -> Bool {
        let regex = "^0([0-9]{1,2})-([0-9]{3,4})-([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
}
