//
//  ContactsError.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/06.
//

import Foundation

enum ContactsError: Error, CustomStringConvertible {
    case invalidPhoneNumber
    case invalidAge
    case invalidName
    
    var description: String {
        switch self {
        case .invalidPhoneNumber:
            return "입력한 연락처\n정보가 잘못되었습니다"
        case .invalidAge:
            return "입력한 나이정보가 잘못되었습니다"
        case .invalidName:
            return "입력한 이름 정보가 잘못되었습니다"
        }
    }
}
