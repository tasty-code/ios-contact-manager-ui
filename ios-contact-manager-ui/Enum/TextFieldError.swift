//
//  TextFieldError.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/15/24.
//

import Foundation

enum TextFieldError: Error {
    case ageTextFieldError
    case nameTextFieldError
    case phoneNumberTextFieldError
    
    var errorMessage: String {
        switch self {
        case .ageTextFieldError:
            "입력한 나이 정보가 잘못되었습니다."
        case .nameTextFieldError:
            "입력한 이름 정보가 잘못되었습니다."
        case .phoneNumberTextFieldError:
            "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
