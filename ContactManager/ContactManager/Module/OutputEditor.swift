//
//  OutputEditor.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct OutputEditor {
    
    func printMenu() {
        print(Menu.greeting, Messages.enterMenu.rawValue, terminator: " ")
    }
    
    func askContactInfo() {
        print(Messages.enterInfo.rawValue, terminator: " ")
    }
    
    func printResult(with person: Person) {
        print("입력한 정보는 \(person.age)세 \(person.name) (\(person.phoneNum))입니다.\n")
    }
    
    func printAskName() {
        print(Messages.enterName.rawValue, terminator: " ")
    }
    
    func printTerminateProgram() {
        print(Messages.terminateProgram.rawValue)
    }
}
