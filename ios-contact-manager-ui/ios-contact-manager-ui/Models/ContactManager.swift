//
//  ContactManager.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class ContactManager {
    private var contacts: [Contact] = []
    
    var contactsCount: Int {
        return contacts.count
    }
    
    func addContact(_ name: String, _ age: String, _ phoneNumber: String) throws {
        guard verifyAge(age) else {
            throw ContactsError.invalidAge
        }
        guard verifyNumber(phoneNumber) else {
            throw ContactsError.invalidPhoneNumber
        }
        
        guard checkDuplicateNumber(phoneNumber) else {
            throw ContactsError.duplicateNumberFound
        }
        
        contacts.append(Contact(name: name, age: age, phoneNumber: phoneNumber))
    }
    
    func deleteContact(index: Int) {
        contacts.remove(at: index)
    }
    
    func showContact(index: Int) -> Contact {
        return contacts[index]
    }
    
    private func verifyAge(_ age: String) -> Bool {
        if let age = Int(age) {
            return true
        }
        return false
    }
    
    private func verifyNumber(_ phoneNumber: String) -> Bool {
        let regex = "^0([0-9]{1,2})-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    private func checkDuplicateNumber(_ phoneNumber: String) -> Bool {
        if contacts.contains(where: { $0.phoneNumber == phoneNumber }) {
            return false
        }
        return true
    }
}
