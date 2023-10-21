//
//  ContactEditDelegate.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/20.
//

import Foundation

protocol ContactEditDelegate: AnyObject {
  func editContact(uid: UUID, name: String, age: Int, phone: String)
}
