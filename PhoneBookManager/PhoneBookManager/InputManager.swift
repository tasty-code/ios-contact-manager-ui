//
//  InputManager.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/21.
//

import Foundation

struct InputManager {
    static func returnArray(userInput: String) -> [String.SubSequence] {
        let nospaceInput = userInput.filter { $0 != " " }
        let returnArray = nospaceInput.split(separator: "/")
        
        return returnArray
    }
    
    static func returnName(returnArray: [String.SubSequence]) -> String? {
        let name = returnArray[0]
        return String(name)
    }
    
    static func returnAge(returnArray: [String.SubSequence]) -> Int? {
        let age = returnArray[1]
        return Int(age)
    }
    
    static func returnPhoneNumber(returnArray: [String.SubSequence]) -> String? {
        let phoneNumber = returnArray[2]
        return String(phoneNumber)
    }
    
    
}
