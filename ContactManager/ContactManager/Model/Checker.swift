//
//  Checker.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/23.
//

import Foundation

class Checker {
    func checkCorrectWord(target: String) -> String {
        switch RegularExpression.init(rawValue: target) {
        case .namePattern:
            return target
        case .agePattern:
            return target
        case .phoneNumberPattern:
            return target
        default:
            print("잘못된 정규식")
        }
        return ""
    }
}
