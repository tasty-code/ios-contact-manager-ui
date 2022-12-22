//
//  InputManager.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/21.
//

import Foundation

enum InputManager {
    static func removeWhiteSpaces(from input: String) -> String {
        return input.filter { $0 != " " }
    }

    static func splitBySlash(from input: String) -> [String] {
        return input.split(separator: "/").map { String($0) }
    }

    static func getName(from array: [String]) -> String {
        return array[0]
    }

    static func getAge(from array: [String]) throws -> Int {
        guard let age = Int(array[1]), 0..<1000 ~= age else {
            throw InputError.invalidAge
        }

        return age
    }

    static func getPhoneNumber(from array: [String]) throws -> String {
        let phoneNumber = array[2]
        let phoneRegEx = #"^\d{2,3}-\d{3,4}-\d{4}$"#
        guard phoneNumber.range(of: phoneRegEx, options: .regularExpression) != nil else {
            throw InputError.invalidPhoneNumber
        }

        return phoneNumber
    }
}
