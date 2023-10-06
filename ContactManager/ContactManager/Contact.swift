//
//  Contact.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/06.
//

import Foundation

struct Contact: Codable {
  var name: String
  var phone: String
  var age: Int
  var uuid: UUID?
  var nameAndAge: String {
    return "\(name)(\(age))"
  }
}


