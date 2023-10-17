//
//  Contact.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/06.
//

import Foundation

struct Contact: Codable {
  let uid: UUID = UUID()
  var name: String
  var age: Int
  var phone: String
  var nameAndAge: String {
    return "\(name)(\(age))"
  }
  
  private enum CodingKeys: CodingKey {
    case name, phone, age
  }
}
