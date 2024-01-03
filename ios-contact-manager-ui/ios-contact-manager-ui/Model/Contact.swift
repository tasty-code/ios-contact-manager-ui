//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct Contact: Equatable {
    var name: String
    var phoneNumber: String
    var age: Int
    
    init(name: String, contact: String, age: Int) {
        self.name = name
        self.phoneNumber = contact
        self.age = age
    }
}
