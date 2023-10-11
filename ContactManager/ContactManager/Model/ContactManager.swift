//
//  ContactManager.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/11.
//

import Foundation

struct ContactManager {
  func nameValidate(_ name: String?) -> Bool {
//    let trimedName = name?.trimmingCharacters(in: .whitespaces)
    if (name ?? "").isEmpty { return false }
    return true
  }
  
  func ageValidate(_ age: Int) -> Bool {
    if age > 999 { return false }
    if age < 0 { return false }
    return true
  }
  
  func phoneValidate(_ phone: String?) -> Bool {
    guard let phone = phone else { return false }
    let dashCount = phone.filter { ($0) == "-" }.count
    if dashCount != 2 { return false }
    if (phone.count - dashCount) <= 9 { return false }
    return true
  }
}
