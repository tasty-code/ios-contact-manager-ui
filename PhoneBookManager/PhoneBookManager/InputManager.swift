//
//  InputManager.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/21.
//

import Foundation

enum InputManager {
    static func userInput() -> String {
        return readLine() ?? ""
    }
    
    static func parse(_ input: String) throws -> [String] {
        func isValidFormat(_ inputArray: [String]) -> Bool {
            return inputArray.count == 3
                && inputArray[0].hasWhiteSpaceAtStartOrEnd() == false
                && inputArray[1].hasWhiteSpace() == false
                && inputArray[2].hasWhiteSpace() == false
        }
        
        var splitedInput = input.components(separatedBy: " / ")
        if isValidFormat(splitedInput) {
            return splitedInput
        }
        
        splitedInput = input.components(separatedBy: "/")
        if isValidFormat(splitedInput) {
            return splitedInput
        }
        
        throw InputError.invalidInput
    }

    static func getName(from array: [String]) -> String {
        return array[0].removeWhiteSpaces()
    }

    static func getAge(from array: [String]) throws -> Int {
        guard let age = Int(array[1]), 0..<1000 ~= age else {
            throw InputError.invalidAge
        }

        return age
    }

    static func getPhoneNumber(from array: [String]) throws -> String {
        let phoneNumber = array[2]
        let phoneRegEx = #"^\d{2,3}-\d{3,4}-\d{4}$"#
        guard phoneNumber.range(of: phoneRegEx, options: .regularExpression) != nil else {
            throw InputError.invalidPhoneNumber
        }

        return phoneNumber
    }
}
