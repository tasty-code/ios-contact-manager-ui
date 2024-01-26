//
//  ContactInputError.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/18.
//


enum ContactInputError: Error {
    case invalidNameError
    case invalidAgeError
    case invalidContactNumberError
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidNameError:
            return "입력한 이름 정보가 잘못되었습니다."
        case .invalidAgeError:
            return "입력한 나이 정보가 잘못되었습니다."
        case .invalidContactNumberError:
            return "입력한 연락처 정보가 잘못되었습니다."
        case .unknown:
            return "알 수 없는 에러가 발생했습니다."
        }
    }
}
