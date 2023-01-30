//
//  UserInputModel.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct UserInputModel {
    let name: String
    let age: String
    let phoneNum: String
    
    func convertToPerson() -> Person? {
        guard let age = Int(age) else { return nil }
        return Person(name: name, age: age, phoneNum: phoneNum)
    }
}
