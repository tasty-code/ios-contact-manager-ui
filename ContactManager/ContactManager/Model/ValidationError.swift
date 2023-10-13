//
//  ValidateError.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/11.
//

import Foundation

enum ValidationError: Error {
  case nameValidationError, phoneValidationError, ageValidationError
  
  var errorMessage: String {
    switch self {
    case .nameValidationError: return "입력한 이름 정보가 잘못되었습니다"
    case .phoneValidationError: return "입력한 연락처 정보가 잘못되었습니다"
    case .ageValidationError: return "입력한 나이 정보가 잘못되었습니다"
    }
  }
}
