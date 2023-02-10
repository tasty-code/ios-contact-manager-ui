//
//  InputManager.swift
//  ContactManager
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
                && inputArray[safe: 0]?.hasWhiteSpaceAtStartOrEnd() == false
                && inputArray[safe: 1]?.hasWhiteSpace() == false
                && inputArray[safe: 2]?.hasWhiteSpace() == false
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
    
    static func contact(from array: [String]) throws -> Contact {
        let name = try name(from: array)
        let age = try age(from: array)
        let phoneNumber = try phoneNumber(from: array)
        
        return Contact(name: name, age: age, phoneNumber: phoneNumber)
        
    }
    
    private static func name(from array: [String]) throws -> String {
        guard let name = array[safe: 0],
                  !name.isEmpty else {
            throw InputError.invalidName
        }
        
        return name.removingWhiteSpaces()
    }
    
    private static func age(from array: [String]) throws -> Int {
        guard let safeValue = array[safe: 1],
              let age = Int(safeValue), 0..<1000 ~= age else {
            throw InputError.invalidAge
        }
        
        return age
    }
    
    private static func phoneNumber(from array: [String]) throws -> String {
        let phoneRegEx = #"^\d{2,3}-\d{3,4}-\d{4}$"#
        guard let phoneNumber = array[safe: 2],
              phoneNumber.range(of: phoneRegEx, options: .regularExpression) != nil else {
            throw InputError.invalidPhoneNumber
        }
        
        return phoneNumber
    }
}
