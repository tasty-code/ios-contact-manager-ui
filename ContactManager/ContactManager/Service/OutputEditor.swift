//
//  OutputEditor.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

protocol OutputEditorProtocol {
    func printMenu()
    func askContactInfo()
    func printResult(with person: Person)
    func askPersonName()
    func printTerminateProgram()
    func showContactList(_ list: String)
    func printEmptyUser(_ user: String)
    func printSearchedUser(_ name: String, _ age: Int, _ phoneNum: String)
    func printEmptyString()
}

struct OutputEditor: OutputEditorProtocol {
    
    func printMenu() {
        print(Menu.greeting, Messages.enterMenu.rawValue, terminator: " ")
    }
    
    func askContactInfo() {
        print(Messages.enterInfo.rawValue, terminator: " ")
    }
    
    func printResult(with person: Person) {
        print("입력한 정보는 \(person.age)세 \(person.name) (\(person.phoneNum))입니다.\n")
    }
    
    func askPersonName() {
        print(Messages.enterName.rawValue, terminator: " ")
    }
    
    func printTerminateProgram() {
        print(Messages.terminateProgram.rawValue)
    }
    
    func showContactList(_ list: String) {
        print(list, terminator: "\n")
    }
    
    func printEmptyUser(_ user: String) {
        print("연락처에 \(user) 이(가) 없습니다.")
    }
    
    func printSearchedUser(_ name: String, _ age: Int, _ phoneNum: String) {
        print("- \(name) / \(age) / \(phoneNum)", terminator: "\n")
    }
    
    func printEmptyString() {
        print("")
    }
}
