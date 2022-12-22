//
//  InputManager.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/21.
//

import Foundation

struct InputManager {
    static func splitInput(from userInput: String) -> [String] {
        let nospaceInput = userInput.filter { $0 != " " }
        let returnArray = nospaceInput.split(separator: "/").map { String($0) }
        
        return returnArray
    }
    
    static func getName(from array: [String]) -> String {
        let name = array[0]
        
        return name
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
