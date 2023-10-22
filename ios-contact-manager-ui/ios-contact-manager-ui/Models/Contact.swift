//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

final class Contact: Codable, Identifiable {
    private(set) var name: String
    private(set) var age: String
    private(set) var phoneNumber: String
    
    init(name: String, age: String, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
    func update(name: String, age: String, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
