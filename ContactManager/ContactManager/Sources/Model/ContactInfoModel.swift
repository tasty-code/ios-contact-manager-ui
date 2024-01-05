//
//  ContactInfoModel.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import Foundation

struct ContactInfoModel {
    
    var name: String
    var age: Int
    var phoneNumber: String
}

extension ContactInfoModel {
    
    static let sampleData: [ContactInfoModel] = [
        ContactInfoModel(name: "james", age: 30, phoneNumber: "05-343-2234"),
        ContactInfoModel(name: "steven", age: 100, phoneNumber: "047-221-3432"),
        ContactInfoModel(name: "hajin", age: 33, phoneNumber: "010-333-23122"),
        ContactInfoModel(name: "tom", age: 23, phoneNumber: "2313-23-232"),
        ContactInfoModel(name: "tomi", age: 23, phoneNumber: "123-123-123"),
        ContactInfoModel(name: "jane", age: 99, phoneNumber: "6988-768-788"),
        ContactInfoModel(name: "july", age: 32, phoneNumber: "05-2222-3234"),
        ContactInfoModel(name: "eren", age: 220, phoneNumber: "123-13-423"),
        ContactInfoModel(name: "gom", age: 53, phoneNumber: "010-222-36722"),
        ContactInfoModel(name: "jin", age: 73, phoneNumber: "683-2543-233432"),
        ContactInfoModel(name: "saejun", age: 42, phoneNumber: "1889-793-677"),
        ContactInfoModel(name: "jinyoung", age: 19, phoneNumber: "111-2222-33333-444"),
        ContactInfoModel(name: "mike", age: 60, phoneNumber: "05-343-2256564"),
        ContactInfoModel(name: "nero", age: 90, phoneNumber: "45457-2221-3432"),
        ContactInfoModel(name: "easy", age: 13, phoneNumber: "0220-333-65122"),
        ContactInfoModel(name: "matthew", age: 63, phoneNumber: "22133-23-23446452"),
        ContactInfoModel(name: "sidi", age: 72, phoneNumber: "968763-123-123"),
        ContactInfoModel(name: "den", age: 09, phoneNumber: "0293-233-1111")
    ]
}
