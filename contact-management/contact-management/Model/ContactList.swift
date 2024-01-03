//
//  ContactList.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

struct ContactList {
    var name: String
    var phoneNumber: String
    var age: Int
    var cnt: Int
    
    init(name: String, phoneNumber: String, age: Int, cnt: Int) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.age = age
        self.cnt = cnt
    }
}
