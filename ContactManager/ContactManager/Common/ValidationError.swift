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

extension NameValidationError: AlertableError {
    var alertConfig: ErrorAlertConfig {
        return .init(body: "입력한 이름 정보가 잘못 되었습니다.")
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

extension AgeValidationError: AlertableError {
    var alertConfig: ErrorAlertConfig {
        return .init(body: "입력한 나이 정보가 잘못 되었습니다.")
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

extension PhoneNumberValidationError: AlertableError {
    var alertConfig: ErrorAlertConfig {
        return .init(body: "입력한 번호 정보가 잘못 되었습니다.")
    }
}
