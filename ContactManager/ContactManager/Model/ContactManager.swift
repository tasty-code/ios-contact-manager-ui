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
  
  func nameValidate(_ name: String?) -> Bool {
    if (name ?? "").isEmpty { return false }
    return true
  }
  
  func ageValidate(_ age: Int?) -> Bool {
    guard let age = age else { return false }
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
