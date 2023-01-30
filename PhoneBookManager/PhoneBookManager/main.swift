//
//  main.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

func execute() {
    print(InfoMessage.requestMenuInput, terminator: "")
    let userInput = InputManager.userInput()
    
    guard let userMenuInput = UserMenu(rawValue: userInput) else {
        print(InputError.invalidMenu.errorDescription ?? "")
        execute()
        return
    }
    
    switch userMenuInput {
    case .addContact:
        addContact()
    case .displayContacts:
        PhoneBookManager.shared.displayContacts()
    case .searchContact:
        PhoneBookManager.shared.searchContact()
    case .quitProgram:
        return
    }
    execute()
    
    func addContact() {
        print(InfoMessage.requestAddContact, terminator: "")
        let userInput = InputManager.userInput()

        do {
            guard userInput.isEmpty == false else {
                throw InputError.emptyInput
            }

            let parsedInput = try InputManager.parse(userInput)
            let contact = try InputManager.contact(from: parsedInput)
            PhoneBookManager.shared.add(contact: contact)
        } catch {
            print(error.localizedDescription)
        }
    }
}

execute()
