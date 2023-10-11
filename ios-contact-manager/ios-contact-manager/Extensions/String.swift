//
//  String.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/11/23.
//

import Foundation

extension String {
    func formatted(by divider: Character = "-") -> String {
        let count = self.count
        var result = self
        
        if let firstCharacter = result.first, firstCharacter == "0" {
            switch count {
            case 4...6:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 3))
            case 7...10:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 3))
                result.insert(divider, at: result.index(result.endIndex, offsetBy: 6 - count))
            case 11:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 3))
                result.insert(divider, at: result.index(result.endIndex, offsetBy: -4))
            default: break
            }
        } else {
            switch count {
            case 3...5:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 2))
            case 6...9:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 2))
                result.insert(divider, at: result.index(result.endIndex, offsetBy: 5 - count))
            case 10:
                result.insert(divider, at: result.index(result.startIndex, offsetBy: 2))
                result.insert(divider, at: result.index(result.endIndex, offsetBy: -4))
            default: break
            }
        }
        
        return result
    }
}
