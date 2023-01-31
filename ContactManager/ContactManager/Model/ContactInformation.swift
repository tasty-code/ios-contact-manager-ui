//
//  ContactInfo.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

struct ContactInformation: Hashable, Codable {
    private(set) var name: String
    private(set) var age: String
    private(set) var phoneNumber: String
    
    enum CondingKeys: String, CodingKey {
        case name = "name"
        case age = "age"
        case phoneNumber = "phoneNumber"
    }
}
