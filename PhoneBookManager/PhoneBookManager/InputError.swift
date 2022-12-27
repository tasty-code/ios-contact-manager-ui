//
//  InputError.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/22.
//

import Foundation

enum InputError: LocalizedError {
    case emptyInput
    case invalidName
    case invalidInput
    case invalidAge
    case invalidPhoneNumber
    
    var errorDescription: String? {
        switch self {
        case .emptyInput:
            return "아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요."
        case .invalidName:
            return "입력한 이름이 잘못되었습니다. 입력 형식을 확인해주세요"
        case .invalidInput:
            return "입력이 올바르지 않습니다."
        case .invalidAge:
            return "입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요."
        case .invalidPhoneNumber:
            return "입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해 주세요."
        }
    }
}
