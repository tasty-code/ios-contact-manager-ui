//
//  ValidError.swift
//  ContactManager
//
//  Created by 유니 & L on 2024/01/15.
//

import Foundation

enum ValidError: LocalizedError {
    case nameValidError, ageValidError, phoneNumberValidError
    
    var errorDescription: String? {
        switch self {
        case .nameValidError:
            return "입력한 이름 정보가 잘못되었습니다."
        case .ageValidError:
            return "입력한 나이 정보가 잘못되었습니다."
        case .phoneNumberValidError:
            return "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
