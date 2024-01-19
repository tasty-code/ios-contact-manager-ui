//
//  StringExtension.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/19/24.
//

import Foundation

extension String {
    public func contains(initial: String.UnicodeScalarView) -> Bool {
        let initialString: String = initial.reduce(into: "") { (characters, character) in
            characters += String(character).lowercased() + " "
        }
        
        let stringArray = Array(self)
        let stringUnicodeScalars = stringArray.reduce(into: "") { (characters, character) in
            guard let unicodeFirst = String(character).decomposedStringWithCompatibilityMapping.unicodeScalars.first else {
                return
            }
            characters += String(unicodeFirst).lowercased() + " "
        }
        
        return stringUnicodeScalars.contains(initialString)
    }
    
    public func contains(subCharacter: String.UnicodeScalarView) -> Bool {
        let subCharacterString: String = subCharacter.reduce(into: "") { (characters, character) in
            characters += String(character).lowercased() + " "
        }
        
        let stringArray = Array(self)
        let stringUnicodeScalars = stringArray.reduce(into: "") { (characters, character) in
            let unicodeScalars = String(character).decomposedStringWithCompatibilityMapping.unicodeScalars
            unicodeScalars.forEach {
                characters += String($0) + " "
            }
        }
        
        return stringUnicodeScalars.contains(subCharacterString)
    }
}
