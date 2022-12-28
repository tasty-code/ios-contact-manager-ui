//
//  ContactManager.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/27.
//

import Foundation

final class ContactManager {
    var contactInformation = [ContactInformation]()
    let detector = Detector()
    let convertor = Converter()
    let checker = Checker()
    
    func startProcess() {
        var identifier: Bool
        
        repeat {
            print(PrintMessage.startComment)
            let receiveUserInputValues = userInputValue()
            if receiveUserInputValues == "" {
                print(PrintMessage.nothingUserInput)
                break
            }
            let convertedUserInputValues = convertor.convertToCharacter(this: receiveUserInputValues)
            let removedBlankUserInputValues = detector.excludeSpaceWord(convertedUserInputValues)
            let combinedUserInputValues = convertor.convertToString(removedBlankUserInputValues)
            let splitedUserInputValues = combinedUserInputValues.split(separator: "/").map{ String($0) }
            
            
            let checkUserInputValues = checker.checkCorrectWord(target: splitedUserInputValues)
            let receivecValues = checker.checkCorrectWord(target: checkUserInputValues)

            identifier = PrintMessage.validUserInput(value: receivecValues)
        } while identifier == true
    }
}

extension ContactManager: InputPossible {
    func userInputValue() -> String {
        guard let userInput = readLine() else {
            return "F"
        }
        return userInput
    }
}
