//
//  Validator.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol ValidatorProtocol {
    func checkValidFormat(input: UserInputModel) throws -> Person
    func checkInputEmpty(with str: String) -> Bool
}

struct Validator: ValidatorProtocol {
    
    //MARK: Constants
    enum Constants {
        static let minimumAge = 1
        static let maximumAge = 999
    }
    
    //MARK: Methods
    func checkValidFormat(input: UserInputModel) throws -> Person {
        let (name, age, number) = (input.name, input.age, input.phoneNum)
        
        do {
            try validateName(name)
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
    
    private func validateName(_ name: String) throws {
        if name.isEmpty { throw Errors.wrongName }
    }
    
    private func validateAge(_ age: String) throws {
        guard let ageInt = Int(age),
              ageInt >= Constants.minimumAge && ageInt <= Constants.maximumAge else { throw Errors.wrongAge }
    }
    
    private func validateNumber(_ number: String) throws {
        let numberSplit = number.split(separator: "-").map { String($0) }
        if number.count < 11 || numberSplit.count < 3 { throw Errors.wrongPhoneNumber }
    }
}
