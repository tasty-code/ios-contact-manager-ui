//
//  phoneNumberFormatter.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/15/24.
//

import Foundation

extension String {
    
    func formatPhoneNumber() -> String {
        var formatText = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var displayedText = formatText
        guard formatText.isEmpty == false else {
            return ""
        }
        
        let symbol:Character = "-"
        
        if formatText.hasPrefix("02") || formatText.hasPrefix("0") == false {
            switch formatText.count {
            case 3...5:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 2))
            case 6...9:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 2))
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 6))
            case 10:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 2))
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 7))
            default:
                break
            }
        } else {
            switch formatText.count {
            case 4...6:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 3))
            case 7...10:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 3))
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 7))
            case 11:
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 3))
                displayedText.insert(symbol, at: displayedText.index(displayedText.startIndex, offsetBy: 8))
            default:
                break
            }
        }
        return displayedText
    }
}
