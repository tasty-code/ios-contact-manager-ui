//
//  Error.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/22.
//

import Foundation

enum IOError: Error {
    case emptyInput
    case invalidProperty(parameter: UserInfoParameters)
    case invalidInputFormat
}

extension IOError: LocalizedError {
    var errorDescription: String? {
        let description:String
        switch self {
        case .emptyInput:
            description = "아무것도 입력되지 않았습니다."
        case let .invalidProperty(parameter):
            description = "입력한 \(parameter.rawValue) 정보가 잘못되었습니다."
        case .invalidInputFormat:
            description = "입력 형식이 잘못되었습니다."
        }
        return "\(description) 입력 형태를 확인해주세요."
    }
}
