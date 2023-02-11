//
//  Converter.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/22.
//

import Foundation

final class Converter: Convertable {
    func renderToCharacter(_ sentence: String) -> [Character] {
        var characters = [Character]()
        
        for character in sentence {
            characters.append(character)
        }
        return characters
    }
    
    func renderToString(_ characters: [Character]) -> String {
        return String(characters)
    }
}
