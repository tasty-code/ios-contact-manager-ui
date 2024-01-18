//
//  ContactInputError.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/18.
//


enum ContactInputError: Error {
    case isValidName
    case isValidAge
    case isValidContactNumber
    
    var errorMessage: String {
        switch self {
        case .isValidName:
            return "입력한 이름 정보가 잘못되었습니다."
        case .isValidAge:
            return "입력한 나이 정보가 잘못되었습니다."
        case .isValidContactNumber:
            return "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
