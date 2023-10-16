//
//  ContactException.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation

enum ContactException: Error, LocalizedError {
    case contactAlreadyExsist(contact: Contact)
    case contactNotFound(contact: Contact)
    case invalidInput(type: InputErrorType)
    
    
    var errorDescription: String? {
        switch self {
        case .contactAlreadyExsist(let contact):
            return "\(contact.name)는(은) 이미 존재합니다."
        case .contactNotFound(let contact):
            return "\(contact.name)는(은) 존재하지 않습니다."
        case .invalidInput(let type):
            return "입력한 \(type)가 잘못되었습니다."
        }
    }
    
    
    enum InputErrorType: CustomStringConvertible {
        case name
        case age
        case phoneNumber
        
        var description: String {
            switch self {
            case .name:
                return "이름 정보"
            case .age:
                return "나이 정보"
            case .phoneNumber:
                return "연락처 정보"
            }
        }
    }
}
