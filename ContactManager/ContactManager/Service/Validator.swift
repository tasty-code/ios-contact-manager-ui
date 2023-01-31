//
//  Validator.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct Validator {
    
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
    
    private func validateAge(_ age: String) throws {
        guard let ageInt = Int(age),
              ageInt >= Constants.minimumAge && ageInt <= Constants.maximumAge else { throw Errors.wrongAge }
    }
    
    private func validateNumber(_ number: String) throws {
        let numberSplit = number.split(separator: "-").map({ String($0) })
        if number.count < 10 || numberSplit.count < 3 { throw Errors.wrongPhoneNumber }
    }
    
    func checkInputEmpty(with str: String) -> Bool {
        return str.isEmpty ? true : false
    }
}
