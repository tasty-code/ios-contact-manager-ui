//
//  SystemMenuWorkable.swift
//  ContactManager
//
//  Created by Jason on 2022/12/29.
//

import Foundation

protocol SystemMenuWorkable {
    func addContact()
    func viewContactList(value: Set<ContactInformation>)
    func searchByName(value: Set<ContactInformation>)
    func exitProgram() -> Bool
}
