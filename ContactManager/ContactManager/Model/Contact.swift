//
//  Contact.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/4/24.
//

import Foundation

struct Contact: Codable {
    
    private var name: String
    private var age: Int
    private var phoneNumber: String
    
    var fetchedName: String {
        return name
    }
    
    var fetchedAge: String {
        return "(\(age))"
    }
    
    var fetchedPhoneNumber: String {
        return phoneNumber
    }
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
