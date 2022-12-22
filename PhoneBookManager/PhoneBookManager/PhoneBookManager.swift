//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

struct PhoneBookManager {
    func run() {
        IOManager.printInputMessage()
        let userInput = IOManager.userInput()
        
        let returnArray = InputManager.returnArray(userInput: userInput)
        let name = InputManager.returnName(returnArray: returnArray)
        let age = InputManager.returnAge(returnArray: returnArray)
        let phoneNumber = InputManager.returnPhoneNumber(returnArray: returnArray)
        print(name!)
        print(age!)
        print(phoneNumber!)
        
    }
}
