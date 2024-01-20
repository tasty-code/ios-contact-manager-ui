//
//  ContactMakable.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

protocol ContactMakable {
    func makeContact(from request: AddContact.Request) throws -> Contact
}

import Foundation

struct ContactFactory: ContactMakable {
    func makeContact(from request: AddContact.Request) throws -> Contact {
        let id = makeID()
        let name = try validateName(request.name)
        let age = try validateAge(request.age)
        let phoneNumber = try validatePhoneNumber(request.phoneNumber)
        return Contact(id: id, name: name, phoneNumber: phoneNumber, age: age)
    }
    
    private func makeID() -> Int {
        return UUID().hashValue
    }
    
    private func validateName(_ name: String) throws -> String {
        guard name.isEmpty == false &&
                name.contains(where: { ch in ch.isWhitespace || ch.isNewline }) == false else {
            throw ContactValidationError.invalidName
        }
        return name
    }
    
    private func validatePhoneNumber(_ phoneNumber: String) throws -> String {
        guard phoneNumber.isEmpty == false else {
            throw ContactValidationError.invalidPhoneNumber
        }
        let onlyNumbers = phoneNumber.filter { ch in ch.isNumber }
        guard onlyNumbers.count >= 9 else {
            throw ContactValidationError.invalidPhoneNumber
        }
        return phoneNumber
    }
    
    private func validateAge(_ age: String) throws -> Int {
        guard age.isEmpty == false,
                let ageNumber = Int(age),
                (0..<100).contains(ageNumber) else {
            throw ContactValidationError.invalidAge
        }
        return ageNumber
    }
}
