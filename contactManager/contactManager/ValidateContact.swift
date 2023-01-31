//
//  ValidateContact.swift
//  contactManager
//
//  Created by 김용재 on 2023/01/31.
//

import Foundation

var isMenuInputError: Bool = false
let regex = "^[A-Za-z\\s]+$"

struct Validation {
    static func validateInputBySlash(input: String) -> Bool {
        guard (input.filter{ $0 == "/" }.count == 2) else {
            return false
        }
        return true
    }

    static func validateInputByHyphenNum(input: String) -> Bool {
        guard (input.filter { $0 == "-" }.count == 2) else {
            return false
        }
        return true
    }
}
