//
//  TextField.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/12/24.
//

import Foundation

enum TextField: CaseIterable {
    case name
    case age
    case phoneNumber
    
    var regex: String {
        switch self {
        case .name:
            return #"^[^\s]+$"#
        case .age:
            return #"^\d{1,3}$"#
        case .phoneNumber:
            return #"^\d{2,}-\d{3,}-\d{4,}$"#
        }
    }
    
    var message: String {
        switch self {
        case .name:
            return "입력한 이름 정보가 잘못되었습니다"
        case .age:
            return "입력한 나이 정보가 잘못되었습니다"
        case .phoneNumber:
            return "입력한 연락처 정보가 잘못되었습니다"
        }
    }
}
