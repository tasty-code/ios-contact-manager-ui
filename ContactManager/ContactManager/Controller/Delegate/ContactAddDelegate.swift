//
//  ContactAddDelegate.swift
//  ContactManager
//
//  Created by 김예준 on 10/17/23.
//

protocol ContactAddDelegate: AnyObject {
  func addContact(name: String, age: Int, phone: String)
}
