//
//  ContactManager.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/27.
//

import Foundation

final class ContactManager {
    var contactInformationArray: Set<ContactInformation> = []
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
                addContact()
                break
            case .viewContact:
                viewContactList(value: contactInformationArray)
                break
            case .searchContact:
                searchByName(value: contactInformationArray)
                break
            case .exit:
                identifier = exitProgram()
                exit(1)
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
        case exit = "x"
        
        var description: String {
            return self.rawValue
        }
    }
}

extension ContactManager: SystemMenuWorkable {
    func addContact() {
        print(PrintMessage.requestContactInformation, terminator: "")
        let receiveUserInputValues = userInputValue()
        if receiveUserInputValues == "" {
            print(PrintMessage.nothingUserInput)
            return
        }
        let convertedUserInputValues = convertor.convertToCharacter(this: receiveUserInputValues)
        let removedBlankUserInputValues = detector.excludeSpaceWord(convertedUserInputValues)
        let combinedUserInputValues = convertor.convertToString(removedBlankUserInputValues)
        let splitedUserInputValues = combinedUserInputValues.split(separator: "/").map{ String($0) }
        
        guard let checkUserInputValues = checker.checkCorrectWord(target: splitedUserInputValues) else {
            return
        }
        contactInformationArray.insert(checkUserInputValues)
        
        PrintMessage.validUserInput(value: checkUserInputValues)
    }
    
    func viewContactList(value: Set<ContactInformation>) {
        PrintMessage.viewContact(list: value)
    }
    
    func searchByName(value: Set<ContactInformation>) {
        print(PrintMessage.requestToSearchName, terminator: "")
        let searchName = userInputValue()
        PrintMessage.searchContact(list: value, word: searchName)
    }
    
    func exitProgram() -> Bool {
        print(PrintMessage.exitProgram)
        return false
    }
}
