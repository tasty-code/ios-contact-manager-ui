//
//  ContactBook.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import Foundation

struct ContactBook {
    private var contactInfomation: [Person] = []
}

extension ContactBook {
    mutating func setContactList (_ list: [Person] ) {
        self.contactInfomation = list
        rangeList()
    }
    
    mutating func addContactList(_ person: Person) {
        let isOverLap: Bool = overlapCheck(person)

        if isOverLap {
            return
        } else {
            self.contactInfomation.append(person)
            rangeList()
        }
    }
    
    mutating func deleteContactList(_ indexPath: IndexPath) {
        self.contactInfomation.remove(at: indexPath.row)
    }
    
    mutating func updateContactList(_ indexPath: IndexPath, _ person: Person) {
        let isOverLap: Bool = overlapCheck(person)

        if isOverLap {
            return
        } else {
            self.contactInfomation[indexPath.row] = person
            rangeList()
        }
    }
    
    mutating func rangeList() {
        self.contactInfomation.sort { $0.name.uppercased() < $1.name.uppercased() }
    }
}

extension ContactBook {
    func getRowCount() -> Int {
        return self.contactInfomation.count
    }
    
    func showContactList(_ indexPath: IndexPath) -> Person {
        return self.contactInfomation[indexPath.row]
    }
    
    func overlapCheck(_ contact: Person) -> Bool {
        if self.contactInfomation.contains(where: ({ $0.name == contact.name && $0.age == contact.age && $0.digits == contact.digits })) {
            return true
        } else {
            return false
        }
    }
}
