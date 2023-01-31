//
//  ContactManager.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/22.
//

import Foundation

typealias InfoInput = (name: String, age: String, phone: String)

final class ContactManager {
    static let shared = ContactManager()
    private init() { }
    
    enum Menu: String {
        case addContact = "1"
        case showAllContacts = "2"
        case findContact = "3"
        case exit = "x"
    }

    private let phonebook = Phonebook(contacts: [:])
    
    func run() {
        do {
            IOManager.sendOutput(
                type: .menu,
                contents: StringLiteral.Menu.start
            )
            let input = try IOManager.getInput()
            
            switch Menu(rawValue: input) {
            case .addContact:
                try addContact()
            case .showAllContacts:
                showAllContacts()
            case .findContact:
                try findContact()
            case .exit:
                IOManager.sendOutput(
                    type: .infomation,
                    contents: StringLiteral.Menu.end
                )
                return
            default:
                IOManager.sendOutput(
                    type: .infomation,
                    contents: StringLiteral.Menu.wrong
                )
            }
        } catch {
            IOManager.sendOutput(
                type: .error,
                contents: error.localizedDescription
            )
        }
        run()
    }
}


// MARK: - addContact

extension ContactManager {
    private func parse(info input: String) throws -> InfoInput {
        let inputPattern = #"^.+\b(?<sep>( \/ )|(\/))(\b[^\s]+\b)\k<sep>(\b[^\s]+)$"#
        
        guard input ~= inputPattern else {
            throw IOError.invalidInputFormat
        }
        let splitedInput = input.components(separatedBy: "/").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        let infoInput = (name: splitedInput[0], age: splitedInput[1], phone: splitedInput[2])
        return infoInput
    }
    
    private func addContact() throws {
        IOManager.sendOutput(
            type: .menu,
            contents: StringLiteral.Contact.add
        )
        let input = try IOManager.getInput()
        let parsedInfoInput = try parse(info: input)
        let userInfo = try UserInfo(input: parsedInfoInput)
        let inserted = phonebook.add(contact: userInfo)
        let description = inserted ? StringLiteral.Contact.added( userInfo.addedDescription) : StringLiteral.Contact.exist
        IOManager.sendOutput(
            type: .infomation,
            contents: description
        )
    }
}

// MARK: - showAllContacts

extension ContactManager {
    private func showAllContacts() {
        let description = phonebook.description ?? StringLiteral.Contact.empty
        IOManager.sendOutput(
            type: .infomation,
            contents: description
        )
    }
}

// MARK: - findContract

extension ContactManager {
    private func parse(name: String) throws -> String {
        return try name.matches(infoType: .name)
    }
    
    private func findContact() throws {
        IOManager.sendOutput(
            type: .menu,
            contents: StringLiteral.Contact.find
        )
        let input = try IOManager.getInput()
        let userName = try parse(name: input)
        let description = phonebook.getContact(of: userName) ?? StringLiteral.Contact.notFound(name: userName)
        IOManager.sendOutput(
            type: .infomation,
            contents: description
        )
    }
}

