//
//  Person.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

struct Person: Hashable {
    let name: String
    let age: Int
    let phoneNum: String
}

extension Person {
    static let dummyData: [Person] = [
        Person(name: "james", age: 30, phoneNum: "05-343-2234"),
        Person(name: "steven", age: 100, phoneNum: "047-221-3432"),
        Person(name: "hajin", age: 33, phoneNum: "010-3332-0093"),
        Person(name: "mini", age: 99, phoneNum: "0323-33-2232"),
        Person(name: "hojun", age: 45, phoneNum: "3-444-19343"),
        Person(name: "dooly", age: 95, phoneNum: "932-39443-23"),
        Person(name: "lucy", age: 1, phoneNum: "000-232-03333"),
        Person(name: "yo", age: 30, phoneNum: "323-43-3333"),
        Person(name: "joy", age: 65, phoneNum: "6894-3-3434"),
        Person(name: "summer", age: 84, phoneNum: "9-32-343323"),
        Person(name: "green", age: 54, phoneNum: "895-3432-344"),
        Person(name: "jisu", age: 30, phoneNum: "05-343-2234"),
        Person(name: "hana", age: 100, phoneNum: "047-221-3432"),
        Person(name: "mike", age: 33, phoneNum: "010-3332-0093"),
        Person(name: "coco", age: 99, phoneNum: "0323-33-2232"),
        Person(name: "tiger", age: 45, phoneNum: "3-444-19343"),
        Person(name: "molly", age: 95, phoneNum: "932-39443-23"),
        Person(name: "bruce", age: 1, phoneNum: "123-456-7890"),
        Person(name: "Alriie", age: 100, phoneNum: "010-000-0000")
        ]
}
