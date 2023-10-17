//
//  ValidateError.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/11.
//

import Foundation

enum ValidationError: Error, LocalizedError {
  case nameValidationError, phoneValidationError, ageValidationError

  var errorDescription: String? {
    switch self {
    case .nameValidationError: return NSLocalizedString("입력한 이름 정보가 잘못되었습니다", comment: "Invalid name")
    case .phoneValidationError: return NSLocalizedString("입력한 연락처 정보가 잘못되었습니다", comment: "Invalid phone")
    case .ageValidationError: return NSLocalizedString("입력한 나이 정보가 잘못되었습니다", comment: "Invalid age")
    }
  }
}
