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
            let convertedUserInputValues = convertToCharacter(this: receiveUserInputValues)
            let removeBlankUserInputValues = removeBlank(from: convertedUserInputValues)
        } while identifier == ""
    }
    
    func getUserInputValues() -> String {
        guard let userInput = readLine() else {
            return "F"
        }
        return userInput
    }
    
    func convertToCharacter(this sentence: String) -> [Character] {
        var characterArray = [Character]()
        
        for index in sentence {
            characterArray.append(index)
        }
        return characterArray
    }
    
    func removeBlank(from characterArray:[Character]) -> [Character] {
        var removeBlankCharacterArray = [Character]()
        
        for character in characterArray {
            if character == " " {
                continue
            } else {
                removeBlankCharacterArray.append(character)
            }
        }
        return removeBlankCharacterArray
    }
    
}

ContactManager().processStart()
