//
//  TemporaryContainer.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/17/23.
//

import Foundation

final class TemporaryContainer {
    private var _contact: Contact?
    var contact: Contact? {
        return self._contact
    }
    
    init(contact: Contact? = nil) {
        self._contact = contact
    }
    
    func formatContact(_ name: String?, _ age: String?, _ phoneNumber: String?) throws {
        let name = try formatNameTextFieldText(name)
        let age = try formatAgeTextFieldText(age)
        let phoneNumber = try formatPhoneNumberTextFieldText(phoneNumber)
        let index = self._contact?.index
        self._contact = Contact(name: name, age: age, phoneNumber: phoneNumber, index: index)
    }
    
    private func formatNameTextFieldText(_ name: String?) throws -> String {
        guard let text = name,
              text.isEmpty == false
        else { throw ContactError.invalidName }
        
        return text.replacingOccurrences(of: " ", with: "")
    }
    
    private func formatAgeTextFieldText(_ age: String?) throws -> Int {
        guard let text = age?.replacingOccurrences(of: " ", with: ""),
              let age = Int(text),
              age >= 0 && age < 1000
        else { throw ContactError.invalidAge }
        
        return age
    }
    
    private func formatPhoneNumberTextFieldText(_ phoneNumber: String?) throws -> String {
        guard let text = phoneNumber?.replacingOccurrences(of: "-", with: ""),
              text.count >= 9,
              let _ = Int(text)
        else { throw ContactError.invalidPhoneNumber }
        
        return text.formatted()
    }
}
