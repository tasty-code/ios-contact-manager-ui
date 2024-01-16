//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/3/24.
//

import Foundation

struct Contact: Decodable, Hashable {
    var name: String
    var phoneNumber: String
    var age: Int
    
    init(name: String, phoneNumber: String, age: Int) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.age = age
    }
}
