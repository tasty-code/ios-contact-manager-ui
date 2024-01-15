//
//  Error.swift
//  ContactManager
//
//  Created by MAC2020 on 2024/01/09.
//

import Foundation

enum ContactManangerError: Error {
    case contactEmpty
    case contactExist
    
    var errorMessage: String {
        switch self {
        case .contactEmpty:
            return "연락처가 비어있습니다"
        case .contactExist:
            return "index를 확인해주세요."
        }
    }
    
}

enum AddedContactError: Error {
    case nameMistake
    case ageMistake
    case phoneNumberMistake
    
    var errorMessage: String {
        switch self {
        case .nameMistake:
            return "입력한 이름 정보가 잘못 되었습니다."
        case .ageMistake:
            return "입력한 나이 정보가 잘못 되었습니다."
        case .phoneNumberMistake:
            return "입력한 연락처 정보가 잘못 되었습니다."
        }
    }
}
