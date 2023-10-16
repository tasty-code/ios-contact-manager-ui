//
//  ValidateType.swift
//  ContactManager
//
//  Created by Janine on 2023/10/11.
//

import Foundation

enum ValidateType {
    case name
    case age
    case phoneNum
    
    var description: String {
        switch self {
        case .name:
            return "이름"
        case .age:
            return "나이"
        case .phoneNum:
            return "연락처"
        }
    }
}
