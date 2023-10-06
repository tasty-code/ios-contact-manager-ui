//
//  ContactBook.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import Foundation

struct ContactBook {
    private var contactInfomation: [Person] = [Person(name: "Yeji", age: "23", digits: "010-1234-1234"), Person(name: "Howard", age: "35", digits: "010-1234-1234"),Person(name: "Dora", age: "23", digits: "010-1234-1234"),Person(name: "Rarla", age: "23", digits: "010-2234-1234")]
}

extension ContactBook {
    mutating func addContactList(_ person: Person) {
        let isOverLap: Bool = overlapCheck(person)

        if isOverLap {
            return
        } else {
            contactInfomation.append(person)
            rangeList()
        }
    }
    
    mutating func deleteContactList(_ indexPath: IndexPath) {
        contactInfomation.remove(at: indexPath.row)
    }
    
    mutating func updateContactList() {
        
    }
    
    mutating func rangeList() {
        contactInfomation.sort { $0.name.uppercased() < $1.name.uppercased()}
    }
}

extension ContactBook {
    func getSectionCount() -> Int {
        return contactInfomation.count
    }
    
    func showContactList(_ indexPath: IndexPath) -> Person {
        return contactInfomation[indexPath.row]
    }
    
    func overlapCheck(_ contact: Person ) -> Bool {
        if contactInfomation.contains(where: ({ $0.name == contact.name && $0.age == contact.age && $0.digits == contact.digits })) {
            return true
        } else {
            return false
        }
    }
}
