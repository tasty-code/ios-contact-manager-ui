//
//  main.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

class ContactManager {
    var contactInfo: [ContactInfo] = []
    let detector = Detector()
    let convertor = Converter()
    
    func processStart() {
        var identifier = ""
        
        repeat {
            print(PrintMessage.startComment)
            let receiveUserInputValues = getUserInputValues()
            let convertedUserInputValues = convertor.convertToCharacter(this: receiveUserInputValues)
            
            let removedBlankUserInputValues = detector.excludeSpaceWord(convertedUserInputValues)
            let slashIndexArray = detector.extractIndexWithSlash(from: removedBlankUserInputValues)
            let extractedName = detector.extractNameCharacter(from: removedBlankUserInputValues, range: slashIndexArray)
            let convertedName = convertor.convertToString(extractedName)
        } while identifier == ""
    }
}

ContactManager().processStart()

extension ContactManager: InputPossible {
    func getUserInputValues() -> String {
        guard let userInput = readLine() else {
            return "F"
        }
        return userInput
    }
}
