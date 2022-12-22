//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

struct PhoneBookManager {
    func run() {
        ConsoleView.printInputMessage()
        let userInput = ConsoleView.userInput()
        
        let inputArray = InputManager.splitInput(from: userInput)
        
        guard inputArray.count == 3 else { return ErrorMessage.invalidInput.printError() }
        
        guard let name = InputManager.getName(from: inputArray) else { return }
        
        guard let age = InputManager.getAge(from: inputArray) else { return ErrorMessage.invalidAge.printError() }
        
        guard let phoneNumber = InputManager.getPhoneNumber(from: inputArray) else { return ErrorMessage.invalidPhoneNumber.printError() }
        
        ConsoleView.printInitialInputInfo(name: name, age: age, phoneNumber: phoneNumber)
        
    }
}
