//
//  ContactsError.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/06.
//

import Foundation

enum ContactsError: Error, CustomStringConvertible {
    case duplicateNumberFound
    case invalidPhoneNumber
    case invalidAge
    
    var description: String {
        switch self {
        case .duplicateNumberFound:
            return "이미 존재하는 번호입니다. \n 다시 입력해 주세요!"
        case .invalidPhoneNumber:
            return "번호 형식이 맞지 않습니다. \n 다시 입력해 주세요!"
        case .invalidAge:
            return "나이 형식이 맞지 않습니다. \n 다시 입력해 주세요!"
        }
    }
}
