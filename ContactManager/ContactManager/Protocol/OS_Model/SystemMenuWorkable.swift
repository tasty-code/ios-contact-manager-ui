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
    func isClosed() -> Bool
}

extension SystemMenuWorkable {
    func showContactList(value: Set<ContactInformation>) {
        PrintMessage.viewContact(list: value)
    }
    
    func isClosed() -> Bool {
        print(PrintMessage.exitProgram)
        return false
    }
}
