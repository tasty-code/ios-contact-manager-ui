//
//  phoneNumberFormatter.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/15/24.
//

import Foundation

extension String {
    
    func extractNumbersFromStrings() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func formatPhoneNumber() -> String {
        let phoneNumberText = self.extractNumbersFromStrings()
        var formattedText = phoneNumberText
        let symbol:Character = "-"
        
        guard phoneNumberText.isEmpty == false else {
            return ""
        }
        
        if phoneNumberText.hasPrefix("02") || phoneNumberText.hasPrefix("0") == false {
            switch phoneNumberText.count {
            case 3...5:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 2))
            case 6...9:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 2))
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 6))
            case 10:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 2))
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 7))
            default:
                break
            }
        } else {
            switch phoneNumberText.count {
            case 4...6:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 3))
            case 7...10:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 3))
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 7))
            case 11:
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 3))
                formattedText.insert(symbol, at: formattedText.index(formattedText.startIndex, offsetBy: 8))
            default:
                break
            }
        }
        return formattedText
    }
}
