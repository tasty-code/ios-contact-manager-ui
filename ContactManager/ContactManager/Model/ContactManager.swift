//
//  ContactManager.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/27.
//

import Foundation

final class ContactManager {
    var contactInformationArray = [ContactInformation]()
    let detector = Detector()
    let convertor = Converter()
    let checker = Checker()
    
    func startProcess() {
        var identifier: Bool = true
        
        repeat {
            print(PrintMessage.startComment, terminator: "")
            let receiveUserInputValues = userInputValue()
            switch MenuStart(rawValue: receiveUserInputValues) {
            case .addContact:
                identifier = addContact()
                break
            case .viewContact:
                break
            case .searchContact:
                break
            case .close:
                closeProgram()
                break
            default:
                print(PrintMessage.choiceWrorngMenu)
            }
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

extension ContactManager {
    enum MenuStart: String, CustomStringConvertible {
        case addContact = "1"
        case viewContact = "2"
        case searchContact = "3"
        case close = "x"
        
        var description: String {
            return self.rawValue
        }
    }
}

extension ContactManager {
    func addContact() -> Bool {
        print(PrintMessage.requestContactInfo, terminator: "")
        let receiveUserInputValues = userInputValue()
        if receiveUserInputValues == "" {
            print(PrintMessage.nothingUserInput)
            return false
        }
        let convertedUserInputValues = convertor.convertToCharacter(this: receiveUserInputValues)
        let removedBlankUserInputValues = detector.excludeSpaceWord(convertedUserInputValues)
        let combinedUserInputValues = convertor.convertToString(removedBlankUserInputValues)
        let splitedUserInputValues = combinedUserInputValues.split(separator: "/").map{ String($0) }
        
        guard let checkUserInputValues = checker.checkCorrectWord(target: splitedUserInputValues) else {
            return false
        }
        contactInformationArray.append(checkUserInputValues)
        print(contactInformationArray)
        
        let isCorrect = PrintMessage.validUserInput(value: checkUserInputValues)
        return isCorrect
    }
    
    func closeProgram() {
        print(PrintMessage.exitProgram)
        exit(1)
    }
}
