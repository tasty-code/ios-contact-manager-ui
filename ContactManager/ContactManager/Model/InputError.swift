//
//  InputError.swift
//  ContactManager
//
//  Created by Mason Kim on 2022/12/22.
//

import Foundation

enum InputError: LocalizedError {
    case invalidMenu
    case emptyInput
    case invalidName
    case invalidInput
    case invalidAge
    case invalidPhoneNumber
    
    var errorDescription: String? {
        switch self {
        case .invalidMenu:
            return "선택이 잘못되었습니다. 확인 후 다시 입력해주세요."
        case .emptyInput:
            return "아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요."
        case .invalidName:
            return "입력한 이름 정보가 잘못되었습니다"
        case .invalidInput:
            return "입력이 올바르지 않습니다."
        case .invalidAge:
            return "입력한 나이 정보가 잘못되었습니다"
        case .invalidPhoneNumber:
            return "입력한 연락처 정보가 잘못되었습니다"
        }
    }
}
