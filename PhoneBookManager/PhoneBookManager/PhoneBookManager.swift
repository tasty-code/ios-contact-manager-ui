//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

struct PhoneBookManager {
    func run() {
        OutputManager.printInputMessage()
        let userInput = InputManager.userInput()
        
        do {
            guard !userInput.isEmpty else { throw InputError.emptyInput }
            
            let inputArray = try InputManager.parse(userInput)
            
            let name = InputManager.getName(from: inputArray)
            let age = try InputManager.getAge(from: inputArray)
            let phoneNumber = try InputManager.getPhoneNumber(from: inputArray)

            OutputManager.printInitialInputInfo(name: name, age: age, phoneNumber: phoneNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
}
