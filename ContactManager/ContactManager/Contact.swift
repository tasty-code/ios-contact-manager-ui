//
//  Contact.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/4/24.
//

import Foundation

struct Contact: Codable {
    
    var name: String
    var age: Int
    var phoneNumber: String
    
    var nameAndAge: String {
        return name + "(\(age))"
    }
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
