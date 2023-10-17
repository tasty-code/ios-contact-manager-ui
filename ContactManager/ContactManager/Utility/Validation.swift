//
//  Validation.swift
//  ContactManager
//
//  Created by 김예준 on 10/17/23.
//

import Foundation

extension String? {
  func getValidName() throws -> String {
    guard let name = self?.components(separatedBy: " ").joined() else { throw ValidationError.nameValidationError }
    if name.isEmpty { throw ValidationError.nameValidationError }
    
    return name
  }
  
  func getValidAge() throws -> Int {
    let age = Int(self?.components(separatedBy: " ").joined() ?? "")
    guard let age = age else { throw ValidationError.ageValidationError }
    if (age > 999) || (age < 0) { throw ValidationError.ageValidationError }
    
    return age
  }
  
  func getValidPhone() throws -> String {
    guard let phone = self else { throw ValidationError.phoneValidationError }
    let dashCount = phone.filter { ($0) == "-" }.count
    if dashCount != 2 { throw ValidationError.phoneValidationError }
    if (phone.count - dashCount) < 9 { throw ValidationError.phoneValidationError }
    
    return phone
  }
}
