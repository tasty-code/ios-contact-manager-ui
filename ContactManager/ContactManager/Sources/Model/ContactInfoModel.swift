//
//  ContactInfoModel.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import Foundation

struct ContactInfoModel: Hashable {
    
    var name: String
    var age: Int
    var phoneNumber: String
    
    init(name: String, age: Int, phoneNumber: String) {
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}

