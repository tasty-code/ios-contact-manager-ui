//
//  Errors.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

enum Errors: LocalizedError {
    case wrongName
    case wrongAge
    case wrongPhoneNumber
    case noUserInput
    case invalidSelect
    case defaultError
    case readFail
    
    var errorDescription: String? {
        switch self {
        case .wrongName:
            return "입력한 이름 정보가 잘못되었습니다"
        case .wrongAge:
            return "입력한 나이정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
        case .wrongPhoneNumber:
            return "입력한 연락처정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
        case .noUserInput:
            return "아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요.\n"
        case .invalidSelect:
            return "선택이 잘못었습니다 확인 후 다시 입력해주세요.\n"
        case .defaultError:
            return "Default Error."
        case .readFail:
            return "Read Fail"
        }
    }
}
