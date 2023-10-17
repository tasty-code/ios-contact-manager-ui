//
//  InputError.swift
//  ContactManager
//
//  Created by 전성수 on 10/12/23.
//

import Foundation

enum InputError: Error, CustomDebugStringConvertible {
    case name
    case age
    case digits
    case exception
    
    var debugDescription: String {
        switch self {
        case .name:
            return "입력한 이름정보가 잘못되었습니다"
        case .age:
            return "입력한 나이정보가 잘못되었습니다"
        case .digits:
            return "입력한 연락처정보가 잘못되었습니다"
        case .exception:
            return "입력한 정보가 잘못되었습니다"
        }
    }
}
