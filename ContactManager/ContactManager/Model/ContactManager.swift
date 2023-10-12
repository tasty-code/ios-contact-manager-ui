//
//  ContactManager.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/11.
//

import UIKit

class ContactManager {
  private var contacts = Array<Contact>()
  
  init() {
    loadData()
  }
  
  private func loadData() {
    do {
      let decoder = JSONDecoder()
      guard let asset = NSDataAsset.init(name: "data") else { return }
      self.contacts = try decoder.decode([Contact].self, from: asset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func addContact(data: Contact) {
    contacts.append(data)
    NotificationCenter.default.post(name: NSNotification.Name("AddContact"),
                                    object: self)
  }
  
  func getContacts() -> Array<Contact> {
    return self.contacts
  }
  
  // MARK: - Validate
  
  func nameValidate(_ name: String?) throws -> String {
    guard let name = name else { throw ValidateError.nameValidateError }
    if name.isEmpty { throw ValidateError.nameValidateError }
    
    return name
  }
  
  func ageValidate(_ age: String?) throws -> Int {
    let age = Int(age ?? "") // 만약 nil이라도 빈문자열로 변환돼서 에러처리 되므로 상관 x
    guard let age = age else { throw ValidateError.ageValidateError }
    if (age > 999) || (age < 0) { throw ValidateError.ageValidateError }
    
    return age
  }
  
  func phoneValidate(_ phone: String?) throws -> String {
    guard let phone = phone else { throw ValidateError.phoneValidateError }
    let dashCount = phone.filter { ($0) == "-" }.count
    if dashCount != 2 { throw ValidateError.phoneValidateError }
    if (phone.count - dashCount) <= 9 { throw ValidateError.phoneValidateError }
    
    return phone
  }
  
}
