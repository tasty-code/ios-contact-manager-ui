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

        let trimmedInput = userInput.removingWhiteSpaces()
        let inputArray = trimmedInput.splitBySlash()

        guard inputArray.count == 3 else {
            return InputError.invalidInput.printConsole()
        }

        do {
            let name = InputManager.getName(from: inputArray)
            let age = try InputManager.getAge(from: inputArray)
            let phoneNumber = try InputManager.getPhoneNumber(from: inputArray)

            ConsoleView.printInitialInputInfo(name: name, age: age, phoneNumber: phoneNumber)
        } catch let error as InputError {
            error.printConsole()
        } catch {

        }
    }
}
