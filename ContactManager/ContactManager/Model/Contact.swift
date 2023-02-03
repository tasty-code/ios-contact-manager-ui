//
//  Contact.swift
//  ContactManager
//
//  Created by 신동오 on 2022/12/28.
//

import Foundation

struct Contact: Hashable {
    var name: String
    var age: Int
    var phoneNumber: String
    
    var description: String {
        return "- \(name) / \(age) / \(phoneNumber)"
    }
    
    var descriptionForAddContact: String {
        return "입력한 정보는 \(age)세 \(name)(\(phoneNumber))입니다."
    }
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
    
    func isNameContaining(keyword: String) -> Bool {
        return name.contains(keyword)
    }
}
