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
}
