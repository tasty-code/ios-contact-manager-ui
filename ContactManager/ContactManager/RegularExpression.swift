//
//  RegularExpression.swift
//  ContactManager
//
//  Created by Jason on 2022/12/23.
//

import Foundation

enum RegularExpression: String {
    case namePattern = "[A-Za-z]"
    case agePattern = "[1-999]"
    case phoneNumberPattern = "^0([0-9]{1,2})-([0-9]{3,4})-([0-9]{4})"
}

class CheckRegularExpression {
    func checkRegularExpression(target: String, pattern: String) -> String? {
        guard let checkedResult = target.range(of: pattern, options: .regularExpression) else {
            return nil
        }
        return "\(checkedResult)"
    }
}
