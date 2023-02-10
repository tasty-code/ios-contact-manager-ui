//
//  Person.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct Person: Hashable, Codable, Comparable {
    
    let name: String
    let age: Int
    let phoneNum: String
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        
        if lhs.name != rhs.name {
            return lhs.name < rhs.name
        } else if lhs.name == rhs.name {
            return lhs.age < rhs.age
        } else {
            return lhs.phoneNum < rhs.phoneNum
        }
    }
}
