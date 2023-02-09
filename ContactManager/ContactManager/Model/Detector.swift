//
//  Detector.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/22.
//

import Foundation

class Detector {
    func removeSpace(_ characters: [Character]) -> [Character] {
        var verifiedCharacters = [Character]()
        
        for character in characters {
            if character != " " {
                verifiedCharacters.append(character)
            }
        }
        return verifiedCharacters
    }
}
