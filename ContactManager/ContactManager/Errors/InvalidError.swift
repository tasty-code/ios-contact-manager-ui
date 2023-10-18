//
//  InvalidError.swift
//  ContactManager
//
//  Created by Janine on 2023/10/11.
//

import Foundation

enum InvalidError: Error, CustomStringConvertible {
    case invalidInput(ValidateType)
    
    var description: String {
        switch self {
        case .invalidInput(let type):
            return "입력하신 \(type.description) 정보가 잘못되었습니다"
        }
    }
}
