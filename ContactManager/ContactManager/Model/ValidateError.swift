//
//  ValidateError.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/11.
//

import Foundation

enum ValidateError: Error {
  case nameValidateError, phoneValidateError, ageValidateError
  
  var errorMessage: String {
    switch self {
    case .nameValidateError: return "입력한 이름 정보가 잘못되었습니다"
    case .phoneValidateError: return "입력한 나이 정보가 잘못되었습니다"
    case .ageValidateError: return "입력한 연락처 정보가 잘못되었습니다"
    }
  }
}
