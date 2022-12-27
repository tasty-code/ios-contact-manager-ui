//
//  main.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

func execute() {
    OutputManager.printInputMessage()
    let userInput = InputManager.userInput()

    do {
        guard userInput.isEmpty == false else {
            throw InputError.emptyInput
        }

        let parsedInput = try InputManager.parse(userInput)

        let name = try InputManager.getName(from: parsedInput)
        let age = try InputManager.getAge(from: parsedInput)
        let phoneNumber = try InputManager.getPhoneNumber(from: parsedInput)

        OutputManager.printInitialInputInfo(name: name, age: age, phoneNumber: phoneNumber)
    } catch {
        print(error.localizedDescription)
    }

}

execute()
