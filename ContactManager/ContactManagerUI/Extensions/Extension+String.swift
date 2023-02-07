//
//  Extension+String.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/02/07.
//

import Foundation

extension String {
    var formattedPhoneNumber: String {
        let pureNumbers = self.filter { $0.isNumber }
        var pattern = ""
        var result: String {
            return pureNumbers.applyPatternOnPureNumbers(pattern: pattern, replacementCharacter: "#")
        }
        
        if pureNumbers.starts(with: "0") && !pureNumbers.starts(with: "02")  {
            if pureNumbers.count <= 10 {
                pattern = "###-###-####"
            }
            if pureNumbers.count == 11 {
                pattern = "###-####-####"
            }
            return result
        }
        
        if pureNumbers.count <= 9 {
            pattern = "##-###-####"
            return result
        }
        
        if pureNumbers.count == 10 {
            pattern = "##-####-####"
            return result
        }
        
        return result
    }
    
    private func applyPatternOnPureNumbers(pattern: String,
                                           replacementCharacter: Character) -> String {
        var numbers = self
        for index in 0 ..< pattern.count {
            guard index < numbers.count else { return numbers }
            let pattenIndex = pattern.index(pattern.startIndex, offsetBy: index)
            let patternCharacter = pattern[pattenIndex]
            
            guard patternCharacter != replacementCharacter else { continue }
            numbers.insert(patternCharacter, at: pattenIndex)
        }
        return numbers
    }
}
