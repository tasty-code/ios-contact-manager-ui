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
        let contact = try InputManager.getContact(from: parsedInput)

        print(contact.description)
    } catch {
        print(error.localizedDescription)
    }

}

execute()
