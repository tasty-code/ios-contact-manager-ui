//
//  PhoneBookManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/29.
//

import Foundation

final class PhoneBookManager {
    static let shared = PhoneBookManager()
    private var contacts: Set<Contact> = []
    
    private init() { }
    
    func execute() {
        print(InfoMessage.menuInput, terminator: "")
        let input = InputManager.userInput()
        
        guard let userMenuInput = UserMenu(rawValue: input) else {
            print(InputError.invalidMenu.errorDescription ?? "")
            execute()
            return
        }
        
        switch userMenuInput {
        case .addContact:
            addContact()
            execute()
        case .lookUpContacts:
            lookUpContacts()
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
                print(contact.descriptionForAddContact)
            } else {
                print(InfoMessage.contactAlreadyExists)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func lookUpContacts() {
        guard contacts.isEmpty == false else {
            return print(InfoMessage.emptyContact)
        }
        
        let sortedContacts = contacts.sorted { $0.name < $1.name }
        sortedContacts.forEach { print($0.description) }
    }

    
}
