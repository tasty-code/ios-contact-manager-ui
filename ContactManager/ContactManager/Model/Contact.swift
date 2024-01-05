//
//  Contact.swift
//  ContactManager
//
//  Created by 유니 & L on 2024/01/05.
//

import Foundation

struct Contact: Codable {
    var id: String
    var name: String
    var age: Int
    var phoneNumber: String
    
    var nameAndAge: String {
        return self.name + "(\(self.age))"
    }
}
