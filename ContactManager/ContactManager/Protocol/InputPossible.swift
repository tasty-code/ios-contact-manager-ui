//
//  InputPossible.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/23.
//

import Foundation

protocol InputPossible {
    func userInputValue() -> String
}

protocol SystemMenuWorkable {
    func addContact()
    func viewContactList(value: [ContactInformation])
    func searchByName(value: [ContactInformation])
    func exitProgram() -> Bool
}
