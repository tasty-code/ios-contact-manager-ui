//
//  ContactInfo.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import Foundation

private let nameRange = 0...5
private let ageRange = 1...100
private let phoneNumberRange = 1...1000
private let letters = "abcdefghijklmnopqrstuvwxyz"

enum ContactInfo {
    case name
    case age
    case phoneNumber

    var random: String {
        switch self {
        case .name:
            return String(nameRange.map { _ in letters.randomElement() ?? Character("") })
        case .age:
            return "\(Int.random(in: ageRange))"
        case .phoneNumber:
            return "\(Int.random(in: phoneNumberRange)) - \(Int.random(in: phoneNumberRange)) - \(Int.random(in: phoneNumberRange))"
        }
    }
}
