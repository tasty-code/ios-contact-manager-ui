//
//  main.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

class ContactManager {
    var contactInfo: [ContactInfo] = []
    
    func processStart() {
        var identifier = ""
        
        repeat {
            print(PrintMessage.startComment)
            let receiveUserInputValues = getUserInputValues()
        } while identifier == ""
    }
    
    func getUserInputValues() -> String {
        guard let userInput = readLine() else {
            return "F"
        }
        return userInput
    }
}

ContactManager().processStart()
