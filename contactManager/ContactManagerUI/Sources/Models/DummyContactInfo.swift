//
//  ContactInfo.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import Foundation

private let lettersRange = "abcdefghijklmnopqrstuvwxyz"

enum DummyContactRange {
    case nameRange
    case ageRange
    case phoneNumberRange
    
    var range: ClosedRange<Int> {
        switch self {
        case .nameRange:
            return 0...5
        case .ageRange:
            return 1...100
        case .phoneNumberRange:
            return 1...1000
        }
    }
}

enum DummyContactInfo {
    case name
    case age
    case phoneNumber

    var random: String {
        switch self {
        case .name:
            return String(DummyContactRange.nameRange.range.map { _ in lettersRange.randomElement() ?? Character("") })
        case .age:
            return "\(Int.random(in: DummyContactRange.ageRange.range))"
        case .phoneNumber:
            return "\(Int.random(in: DummyContactRange.phoneNumberRange.range)) - \(Int.random(in: DummyContactRange.phoneNumberRange.range)) - \(Int.random(in: DummyContactRange.phoneNumberRange.range))"
        }
    }
}
