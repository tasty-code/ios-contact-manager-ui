//
//  Checker.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/23.
//

import Foundation

class Checker {
    func checkCorrectWord(target: [String]) -> [String] {
        var isValidName: Bool = false
        var isValidAge: Bool = false
        var isValidPhoneNumber: Bool = false
        var passOfRegulationExpressionArray = [String]()
        
        target.indices.forEach{
            switch $0 {
            case 0:
                let isCorrectName = target[$0].range(of: RegularExpression.namePattern.rawValue, options: .regularExpression) != nil
                if isCorrectName == true {
                    isValidName = isCorrectName
                } else {
                    print(PrintMessage.invalidName)
                }
                break
            case 1:
                let isCorrectAge = target[$0].range(of: RegularExpression.agePattern.rawValue, options: .regularExpression) != nil
                if isCorrectAge == true {
                    isValidAge = isCorrectAge
                } else {
                    print(PrintMessage.invalidAge)
                }
                break
            case 2:
                let isCorrectPhoneNumber = target[$0].range(of: RegularExpression.phoneNumberPattern.rawValue, options: .regularExpression) != nil
                if isCorrectPhoneNumber == true {
                    isValidPhoneNumber = isCorrectPhoneNumber
                } else {
                    print(PrintMessage.invalidPhoneNumber)
                }
                break
            default:
                return
            }
        }
        
        if isValidName == true && isValidAge == true && isValidPhoneNumber == true {
            passOfRegulationExpressionArray = target
        }
        return passOfRegulationExpressionArray
    }
}
