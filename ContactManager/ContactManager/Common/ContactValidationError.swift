//
//  ContactValidationError.swift
//  ContactManager
//
//  Created by Effie on 1/15/24.
//

enum ContactValidationError: Error {
    case invalidName
    case invalidAge
    case invalidPhoneNumber
}

extension ContactValidationError: AlertableError {
    var alertConfig: ErrorAlertConfig {
        switch self {
        case .invalidName:
            return .init(body: "입력한 이름 정보가 잘못 되었습니다.")
        case .invalidAge:
            return .init(body: "입력한 나이 정보가 잘못 되었습니다.")
        case .invalidPhoneNumber:
            return .init(body: "입력한 번호 정보가 잘못 되었습니다.")
        }
    }
}
