//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct Contact {
    var name: String
    var contact: String
    var age: Int
    
    init(name: String, contact: String, age: Int) {
        self.name = name
        self.contact = contact
        self.age = age
    }
}
