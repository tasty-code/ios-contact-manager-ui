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
    
    func addContact() {
        print(InfoMessage.requestAddContact, terminator: "")
        let userInput = InputManager.userInput()

        do {
            guard userInput.isEmpty == false else {
                throw InputError.emptyInput
            }

            let parsedInput = try InputManager.parse(userInput)
            let contact = try InputManager.contact(from: parsedInput)
            
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
    
    func displayContacts() {
        guard contacts.isEmpty == false else {
            return print(InfoMessage.emptyContact)
        }
        
        let sortedContacts = contacts.sorted { $0.name < $1.name }
        sortedContacts.forEach { print($0.description) }
    }
    
    func searchContact() {
        print(InfoMessage.requestSearchContact, terminator: "")
        let userInput = InputManager.userInput()
        
        let searchedContact = contacts.filter {
            $0.isNameContaining(keyword: userInput)
        }
        
        guard searchedContact.isEmpty == false else {
            return print(InfoMessage.noSearchedContact(for: userInput))
        }
        
        searchedContact.forEach { print($0.description) }
    }
}
