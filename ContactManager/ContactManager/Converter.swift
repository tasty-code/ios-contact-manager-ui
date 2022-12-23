//
//  Converter.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/22.
//

import Foundation

class Converter {
    func convertToCharacter(this sentence: String) -> [Character] {
        var characterArray = [Character]()
        
        for index in sentence {
            characterArray.append(index)
        }
        return characterArray
    }
    
    func convertToString(_ word: [Character]) -> String {
        return String(word)
    }
}
