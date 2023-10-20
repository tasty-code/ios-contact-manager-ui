//
//  ContactEditDelegate.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/20.
//

import Foundation

protocol ContactEditDelegate {
  func editContact(uid: UUID, name: String, age: Int, phone: String)
}
