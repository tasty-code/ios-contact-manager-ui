//
//  Checker.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/23.
//

import Foundation

class Checker {
    func checkCorrect(targets: [String]) -> [Bool] {
        var checkResults = [Bool]()
        
        for (target, pattern) in zip(targets, RegularExpression.allCases) {
            let isValid = target.range(of: pattern.rawValue, options: .regularExpression) != nil
            checkResults.append(isValid)
        }
        return checkResults
    }
    
    func checkCorrectWord(target: [String]) -> ContactInformation? {
        var nameValue: String = ""
        var ageValue: String = ""
        var phoneNumberValue: String = ""
        
        target.indices.forEach {
            switch $0 {
            case 0:
                let isCorrectName = target[$0].range(of: RegularExpression.namePattern.rawValue, options: .regularExpression) != nil
                if isCorrectName == true {
                    nameValue = target[0]          // 값 지정
                } else {
                    print(InputErrorMessage.invalidName)
                }
                break
            case 1:
                let isCorrectAge = target[$0].range(of: RegularExpression.agePattern.rawValue, options: .regularExpression) != nil
                if isCorrectAge == true {
                    ageValue = target[1]
                } else {
                    print(InputErrorMessage.invalidAge)
                }
                break
            case 2:
                let isCorrectPhoneNumber = target[$0].range(of: RegularExpression.phoneNumberPattern.rawValue, options: .regularExpression) != nil
                if isCorrectPhoneNumber == true {
                    phoneNumberValue = target[2]
                } else {
                    print(InputErrorMessage.invalidPhoneNumber)
                }
                break
            default:
                return
            }
        }
        
        guard nameValue != "" && ageValue != "" && phoneNumberValue != "" else {
            return nil
        }
        
        return ContactInformation(name: nameValue, age: ageValue, phoneNumber: phoneNumberValue)
    }
}
