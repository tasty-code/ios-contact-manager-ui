//
//  RegularExpression.swift
//  ContactManager
//
//  Created by Jason on 2022/12/23.
//

import Foundation

enum RegularExpression: String, CustomStringConvertible {
    case namePattern = "[A-Za-z]"
    case agePattern = "[1-999]"
    case phoneNumberPattern = "^0([0-9]{1,2})-([0-9]{3,4})-([0-9]{4})"
    
    var description: String {
        return self.rawValue
    }
}
