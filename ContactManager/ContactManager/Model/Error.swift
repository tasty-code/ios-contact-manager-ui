//
//  Error.swift
//  ContactManager
//
//  Created by MAC2020 on 2024/01/09.
//

import Foundation

enum ContactManangerError: Error {
    case contactEmpty
    case contactExist
    
    var errorMessage: String {
        switch self {
        case .contactEmpty:
            return "연락처가 비어있습니다"
        case .contactExist:
            return "index를 확인해주세요."
        }
    }
    
}
