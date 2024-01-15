//
//  ValidationError.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

protocol NoticableError {
    var noticeMessage: String { get }
}

protocol ValidationError: Error, NoticableError { }

enum NameValidationError: ValidationError {
    case cannotContainBlank
    
    var noticeMessage: String {
        switch self {
        case .cannotContainBlank: return "이름은 공백을 포함할 수 없어요."
        }
    }
}

enum AgeValidationError: ValidationError {
    case shouldBeUnderHundred
    case cannotStartWithZero
    
    var noticeMessage: String {
        switch self {
        case .shouldBeUnderHundred: return "나이는 두 자리 이상일 수 없어요."
        case .cannotStartWithZero: return "나이는 0으로 시작할 수 없어요."
        }
    }
}

enum PhoneNumberValidationError: ValidationError {
    case minimumLengthError(_ minimumLength: Int)
    
    var noticeMessage: String {
        switch self {
        case .minimumLengthError(let length): 
            return "전화번호는 최소 \(length)자리 이상이어야 해요."
        }
    }
}
