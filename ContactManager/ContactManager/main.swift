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
            let removedBlankUserInputValues = excludeSpaceWord(convertedUserInputValues)
            let slashIndexArray = extractIndexWithSlash(from: removedBlankUserInputValues)
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
    
    func excludeSpaceWord(_ originInputData: [Character]) -> [Character] {
        var filteredData = [Character]()
        
        for element in originInputData {
            if element != " " {
                filteredData.append(element)
            }
        }
        return filteredData
    }
    
    func extractIndexWithSlash(from originInputData: [Character]) -> [Int] {
        var dividerIndexesArray = [Int]()
        
        for element in originInputData {
            var indexCounter = 0
            
            if element == "/" {
                dividerIndexesArray.append(indexCounter)
            }
            indexCounter += 1
        }
        return dividerIndexesArray
    }
}

ContactManager().processStart()
