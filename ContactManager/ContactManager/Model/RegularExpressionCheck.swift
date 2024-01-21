//
//  IsRegularExpressionCheck.swift
//  ContactManager
//
//  Created by 유니 & L on 2024/01/15.
//

import Foundation

enum RegularExpressionCheck {
    case name, age, phoneNumber
    
    var regex: String {
        switch self {
        case .name:
            return "^[^\\s]+$"
        case .age:
            return "^[0-9]{1,3}$"
        case .phoneNumber:
            return #"(\+[0-9]{2,3}\s?)?(\(0\))?\s?[01]?[0-9]-?([0-9]{3,4})-?([0-9]{4})$"#
        }
    }
    
    static func isValidString(string: String, forPattern pattern: RegularExpressionCheck) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern.regex)
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) != nil
        } catch {
            return false
        }
    }
}
