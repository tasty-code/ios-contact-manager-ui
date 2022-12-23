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
    let checker = Checker()
    
    func processStart() {
        var identifier = ""
        
        repeat {
            print(PrintMessage.startComment)
            let receiveUserInputValues = getUserInputValues()
            let convertedUserInputValues = convertor.convertToCharacter(this: receiveUserInputValues)
            
            let removedBlankUserInputValues = detector.excludeSpaceWord(convertedUserInputValues)
            let slashIndexArray = detector.extractIndexWithSlash(from: removedBlankUserInputValues)
            
            guard let firstSlashIndex = slashIndexArray.first else {
                return
            }
            guard let lastSlashIndex = slashIndexArray.last else {
                return
            }
            
            let inputValuesCount = convertedUserInputValues.count
            
            let nameWord = joinWords(first: 0, second: firstSlashIndex, this: removedBlankUserInputValues)
            let ageWord = joinWords(first: firstSlashIndex, second: lastSlashIndex, this: removedBlankUserInputValues)
            let phoneNumberWord = joinWords(first: lastSlashIndex, second: inputValuesCount, this: removedBlankUserInputValues)
            
            // 문자열 정규식 표현 검사
            let nameString = checker.checkCorrectWord(target: convertor.convertToString(nameWord))
            let ageString = checker.checkCorrectWord(target: convertor.convertToString(ageWord))
            let phoneNumberString = checker.checkCorrectWord(target: convertor.convertToString(phoneNumberWord))
            
            print(nameString, ageString, phoneNumberString)

//            let extractedName = detector.extractNameCharacter(from: removedBlankUserInputValues, range: slashIndexArray)
//            let convertedName = convertor.convertToString(extractedName)
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

extension ContactManager {
    func joinWords(first index1: Int, second index2: Int, this word: [Character]) -> [Character] {
        var usefulValue = [Character]()
        for index in index1..<index2 {
            usefulValue.append(word[index])
            if word[index] != "/" {
                break
            }
        }
        return usefulValue
    }
}
