//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/29.
//

import Foundation

final class PhoneBookManager {
    static let shared = PhoneBookManager()
    private init() {}
    
    private var contacts: Set<Contact> = []
    
    func execute() {
        print(InfoMessage.menuInput, terminator: "")
        let userMenuInput = InputManager.userInput()
        
        guard let userMenuInput = UserMenu(rawValue: userMenuInput) else {
            print(InputError.invalidMenu.errorDescription ?? "")
            execute()
            return
        }
        
        switch userMenuInput {
        case .addContact:
            addContact()
            execute()
        case .viewContacts:
            execute()
        case .searchContact:
            execute()
        case .quitProgram:
            return
        }
    }

    func addContact() {
        print(InfoMessage.addContact, terminator: "")
        let userInput = InputManager.userInput()

        do {
            guard userInput.isEmpty == false else {
                throw InputError.emptyInput
            }

            let parsedInput = try InputManager.parse(userInput)
            let contact = try InputManager.getContact(from: parsedInput)
            
            let isInserted = contacts.insert(contact).inserted
            if isInserted {
                print(contact.description)
            } else {
                print(InfoMessage.contactAlreadyExists)
            }

        } catch {
            print(error.localizedDescription)
        }
    }

    
}
