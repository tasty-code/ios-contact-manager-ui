//
//  Detector.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/22.
//

import Foundation

final class Remover: Removable {
    func removeSpace(from characters: [Character]) -> [Character] {
        var verifiedCharacters = [Character]()
        
        for character in characters {
            if character != " " {
                verifiedCharacters.append(character)
            }
        }
        return verifiedCharacters
    }
}
