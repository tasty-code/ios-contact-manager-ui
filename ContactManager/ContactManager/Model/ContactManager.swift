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
  
  func addContact(nameText: String?, ageText: String?, phoneText: String?) throws {
    let name = try getValidName(nameText)
    let age = try getValidAge(ageText)
    let phone = try getValidPhone(phoneText)
    
    let data = Contact(name: name, age: age, phone: phone)
    contacts.append(data)
    NotificationCenter.default.post(name: NSNotification.Name("AddContact"),
                                    object: self)
  }
  
  func getContacts() -> Array<Contact> {
    return self.contacts
  }
  
  // MARK: - Validate
  
  private func getValidName(_ name: String?) throws -> String {
    guard let name = name else { throw ValidationError.nameValidationError }
    if name.isEmpty { throw ValidationError.nameValidationError }
    
    return name
  }
  
  private func getValidAge(_ age: String?) throws -> Int {
    let age = Int(age ?? "") // 만약 nil이라도 빈문자열로 변환돼서 에러처리 되므로 상관 x
    guard let age = age else { throw ValidationError.ageValidationError }
    if (age > 999) || (age < 0) { throw ValidationError.ageValidationError }
    
    return age
  }
  
  private func getValidPhone(_ phone: String?) throws -> String {
    guard let phone = phone else { throw ValidationError.phoneValidationError }
    let dashCount = phone.filter { ($0) == "-" }.count
    if dashCount != 2 { throw ValidationError.phoneValidationError }
    if (phone.count - dashCount) <= 9 { throw ValidationError.phoneValidationError }
    
    return phone
  }
}
