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
    let (name, age, phone) = try getValidData(nameText: nameText, ageText: ageText, phoneText: phoneText)
    let data = Contact(name: name, age: age, phone: phone)
    contacts.append(data)
    
    NotificationCenter.default.post(name: NSNotification.Name("AddContact"),
                                    object: self)
  }
  
  func getValidData(nameText: String?, ageText: String?, phoneText: String?) throws -> (String, Int, String) {
    let name = try nameText.getValidName()
    let age = try ageText.getValidAge()
    let phone = try phoneText.getValidPhone()
    
    return (name: name, age: age, phone: phone)
  }
  
  func getContacts() -> Array<Contact> {
    return self.contacts
  }
}
