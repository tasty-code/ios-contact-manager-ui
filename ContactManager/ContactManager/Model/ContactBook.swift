//
//  ContactBook.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import Foundation

struct ContactBook {
    private var contactInfomation: [[Person]] = [[Person(name: "Yeji", digits: "010-1234-1234", age: "23"), Person(name: "Howard", digits: "010-1234-1234", age: "35"),Person(name: "Dora", digits: "010-1234-1234", age: "23"),Person(name: "Rarla", digits: "010-2234-1234", age: "23")]]
    
    func getSectionCount() -> Int {
        return contactInfomation.count
    }
    
    func showContactList(_ indexPath: IndexPath) -> Person {
        return contactInfomation[indexPath.section][indexPath.row]
    }
    
    func addContactList() {
        
    }
    
    mutating func deleteContactList(_ indexPath: IndexPath) {
        contactInfomation[indexPath.section].remove(at: indexPath.row)
    }
    
    func updateContactList() {
        
    }
}
