//
//  ContactInfo.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation

struct ContactInfo {
    var name: String?
    var age: Int?
    var phoneNum: String?
    let uuid: UUID
    
    init(name: String, age: Int, phoneNum: String) {
        self.name = name
        self.age = age
        self.phoneNum = phoneNum
        self.uuid = UUID()
    }
}
