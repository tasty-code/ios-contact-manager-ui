//
//  ContactInfo.swift
//  ContactManager
//
//  Created by Janine on 2023/10/04.
//

import Foundation

struct Root: Codable {
    let data: [ContactInfo]
}

struct ContactInfo: Codable {
    var name: String?
    var age: Int?
    var phoneNum: String?
    let uuid: UUID
    
    init(name: String, age: Int, phoneNum: String, uuid: UUID? = nil) {
        self.name = name
        self.age = age
        self.phoneNum = phoneNum
        
        guard let identifier = uuid else {
            self.uuid = UUID()
            return
        }
        self.uuid = identifier
    }
}
