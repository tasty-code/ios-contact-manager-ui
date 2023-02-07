//
//  CreateContact.swift
//  ContactManager
//
//  Created by jun on 2023/01/31.
//

import Foundation

extension ContactManager {
    func createContact() throws -> Contact? {
        Message.pleaseInputContactData.printSelf()
        guard let input: String = try getLine() else {
            return nil
        }
        let raw: (name: String, age: String, phoneNumber: String) = try split(input: input)
        let name: String = try getName(input: raw.name)
        let age: UInt = try getAge(input: raw.age)
        try isValidPhoneNumber(raw.phoneNumber)
        let phoneNumber: String = raw.phoneNumber
        return Contact(name: name, age: age, phoneNumber: phoneNumber)
    }

    private func split(input: String) throws -> (String, String, String) {
        var splitted = input.components(separatedBy: " / ")
        if splitted.count != 3 {
            splitted = input.components(separatedBy: "/")
            if splitted.count != 3 {
                throw ContactManagerError.invalidInput
            }
        }
        let indexOfName = 0
        let indexOfAge = 1
        let indexOfPhoneNumber = 2
        return (splitted[indexOfName], splitted[indexOfAge], splitted[indexOfPhoneNumber])
    }
}

func getName(input: String) throws -> String {
    guard input.isEmpty == false else {
        throw ContactManagerError.invalidName
    }
    guard input.hasPrefix(" ") == false, input.hasSuffix(" ") == false else {
        throw ContactManagerError.invalidName
    }
    guard input.allSatisfy({$0.isLowercase || $0.isUppercase || $0 == " "}) else {
        throw ContactManagerError.invalidName
    }
    return input.components(separatedBy: [" "]).joined()
}

func getAge(input: String) throws -> UInt {
    if input == "0" {
        return 0
    }
    guard input.hasPrefix("0") == false else {
        throw ContactManagerError.invalidAge
    }
    guard let age = UInt(input), age < 1000 else {
        throw ContactManagerError.invalidAge
    }
    return age
}

func isValidPhoneNumber(_ phoneNumber: String) throws {
    guard phoneNumber.filter({ $0.isNumber }).count > 8 else {
        throw ContactManagerError.invalidPhoneNumber
    }
    let digits = phoneNumber.components(separatedBy: ["-"])
    guard digits.count == 3 else {
        throw ContactManagerError.invalidPhoneNumber
    }
    for digit in digits {
        guard Int(digit) != nil else {
            throw ContactManagerError.invalidPhoneNumber
        }
    }
}

