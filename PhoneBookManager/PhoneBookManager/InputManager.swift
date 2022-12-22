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
    
    static func getName(from array: [String]) -> String? {
        let name = array[0]
        return name
    }
    
    static func getAge(from array: [String]) -> Int? {
        guard let age = Int(array[1]) else { return nil }
        guard 0..<1000 ~= age else { return nil }
        return age
    }
    
    static func getPhoneNumber(from array: [String]) -> String? {
        let phoneRegEx = #"^\d{2,3}-\d{3,4}-\d{4}$"#
        let phoneNumber = array[2]
        guard phoneNumber.range(of: phoneRegEx, options: .regularExpression) != nil else { return nil }
        return phoneNumber
    }
    
    
}
