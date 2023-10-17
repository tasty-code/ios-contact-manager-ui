//
//  ContactError.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/10/23.
//

import Foundation

enum ContactError: Error, CustomStringConvertible {
    case invalidName, invalidAge, invalidPhoneNumber
    
    var description: String {
        switch self {
        case .invalidName: return "입력한 이름 정보가 잘못되었습니다."
        case .invalidAge: return "입력한 나이 정보가 잘못되었습니다."
        case .invalidPhoneNumber: return "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
