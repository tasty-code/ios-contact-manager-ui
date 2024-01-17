//
//  Contact.swift
//  Contact-Manager-iOS
//
//  Created by Doyoung An on 1/5/24.
//

struct Contact {
    static var contactsCounting: Int = 0
    let id: Int
    var name: String
    var age: String?
    var contactNumber: String?
    
    init(name: String, age: String? = nil, contactNumber: String? = nil) {
        self.id = Contact.contactsCounting == 0 ? 0 : Contact.contactsCounting
        self.name = name
        self.age = age
        self.contactNumber = contactNumber
        Contact.contactsCounting += 1
    }
}
