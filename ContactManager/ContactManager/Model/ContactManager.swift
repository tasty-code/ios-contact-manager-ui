//
//  ContactManager.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/27.
//

import Foundation

final class ContactManager: InputPossible {
    var contactInformationArray: Set<ContactInformation> = []
    let detector: Detectable
    let convertor: Convertable
    let checker: Checkable
    
    init(detector: Detectable = Detector(), convertor: Convertable = Converter(), checker: Checkable = Checker()) {
        self.detector = detector
        self.convertor = convertor
        self.checker = checker
    }
    
    func startProcess() {
        var identifier: Bool = true
        
        repeat {
            print(PrintMessage.startComment, terminator: "")
            let receiveUserInputValues = userInputValue()
            switch WorkList(rawValue: receiveUserInputValues) {
            case .add:
                addContact()
                break
            case .view:
                viewContactList(value: contactInformationArray)
                break
            case .search:
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

extension ContactManager: SystemMenuWorkable {
    func addContact() {
        print(PrintMessage.requestContactInformation, terminator: "")
        let receiveUserInputValues = userInputValue()
        if receiveUserInputValues == "" {
            print(PrintMessage.nothingUserInput)
            return
        }
        let combinedUserInputValues = removeBlankInput(value: receiveUserInputValues)
        let splitedUserInputValues = combinedUserInputValues.split(separator: "/").map{ String($0) }
        
        guard let checkUserInputValues = checker.checkCorrectWord(target: splitedUserInputValues) else {
            return
        }
        contactInformationArray.insert(checkUserInputValues)
        
        PrintMessage.validUserInput(value: checkUserInputValues)
    }
    
    func removeBlankInput(value: String) -> String {
        let convertedUserInputValues = convertor.renderToCharacter(value)
        let removedBlankUserInputValues = detector.removeSpace(convertedUserInputValues)
        let validName = convertor.renderToString(removedBlankUserInputValues)
        return validName
    }
    
    func searchByName(value: Set<ContactInformation>) {
        print(PrintMessage.requestToSearchName, terminator: "")
        let searchName = userInputValue()
        PrintMessage.searchContact(list: value, word: searchName)
    }
}
