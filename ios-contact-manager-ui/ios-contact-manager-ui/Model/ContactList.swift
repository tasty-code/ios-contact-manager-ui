//
//  ContactList.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct ContactList {
    private var contactList: Dictionary<String, Contact>
    
    init() {
        self.contactList = [:]
    }
    
    public func showContactList() -> Array<Contact> {
        return contactList.sorted(by: { $0.value.name > $1.value.name }).map { $0.value }
    }
}
