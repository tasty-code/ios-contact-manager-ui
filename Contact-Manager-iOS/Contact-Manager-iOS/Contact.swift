//
//  Contact.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/5/24.
//

struct Contact {
    var name: String?
    var age: String?
    var contctNumber: String?
    
    init(name: String? = nil, age: String? = nil, contctNumber: String? = nil) {
        self.name = name
        self.age = age
        self.contctNumber = contctNumber
    }
}
