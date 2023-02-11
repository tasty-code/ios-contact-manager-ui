//
//  SystemMenuWorkable.swift
//  ContactManager
//
//  Created by Jason on 2022/12/29.
//

import Foundation

internal protocol SystemMenuWorkable {
    func addContact()
    func showContactList(value: Set<ContactInformation>)
    func searchByName(value: Set<ContactInformation>)
    func exitProgram() -> Bool
}

extension SystemMenuWorkable {
    func showContactList(value: Set<ContactInformation>) {
        PrintMessage.viewContact(list: value)
    }
    
    func exitProgram() -> Bool {
        print(PrintMessage.exitProgram)
        return false
    }
}
