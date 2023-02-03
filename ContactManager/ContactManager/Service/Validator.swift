//
//  Validator.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol ValidatorProtocol {
    func checkValidAgeAndNum(input: UserInputModel) throws -> Person
    func checkInputEmpty(with str: String) -> Bool
}

struct Validator: ValidatorProtocol {
    
    func checkValidAgeAndNum(input: UserInputModel) throws -> Person {
        let (age, number) = (input.age, input.phoneNum)
        
        do {
            try validateAge(age)
            try validateNumber(number)
            let person = input.convertToPerson()
            if let person = person { return person } else { throw Errors.defaultError }
        } catch {
            throw error
        }
    }
    
    func checkInputEmpty(with str: String) -> Bool {
        return str.isEmpty ? true : false
    }
    
    private func validateAge(_ age: String) throws {
        guard let ageInt = Int(age),
              ageInt >= Constants.minimumAge && ageInt <= Constants.maximumAge else { throw Errors.wrongAge }
    }
    
    private func validateNumber(_ number: String) throws {
        let numberSplit = number.split(separator: "-").map { String($0) }
        if number.count < 10 || numberSplit.count < 3 { throw Errors.wrongPhoneNumber }
    }
    
    func formmatingPhoneNumber(with number: String) -> String {
        let stringCount = number.count
        var phoneNumber = number.map{ String($0) }
        if stringCount < 9 {
            return "Should be Error"
        }
        if stringCount >= 10 {
            phoneNumber.insert("-", at: 3)
            phoneNumber.insert("-", at: 7)
            return phoneNumber.joined()
        } else {
            phoneNumber.insert("-", at: 2)
            phoneNumber.insert("-", at: 6)
            return phoneNumber.joined()
        }
    }
}
