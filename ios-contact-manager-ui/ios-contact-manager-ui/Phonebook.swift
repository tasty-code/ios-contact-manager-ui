//
//  Phonebook.swift
//  ios-contact-manager
//
//  Created by sei on 2022/12/28.
//

import Foundation

final class Phonebook {
    private var contacts: [String:Set<UserInfo>]
    
    var description: String? {
        guard false == contacts.isEmpty else {
            return nil
        }
        let sortedContacts = contacts.sorted { $0.key < $1.key }
        let result = sortedContacts.reduce("") { partialResult, contact in
            partialResult + description(of: contact.value)
        }
        return result
    }
    
    init(contacts: [String:Set<UserInfo>]) {
        self.contacts = contacts
    }
    
    func add(contact: UserInfo) -> Bool {
        let (inserted, _) = contacts[contact.name, default: Set<UserInfo>()].insert(contact)
        return inserted
    }
    
    func getContact(of name: String) -> String? {
        guard let foundUserInfos = contacts[name] else {
            return nil
        }
        return description(of: foundUserInfos)
    }
    
    private func description(of userInfos: Set<UserInfo>) -> String {
        userInfos.reduce("") { partialResult, currentUserInfo in
            return partialResult + "- \(currentUserInfo)\n"
        }
    }
}
