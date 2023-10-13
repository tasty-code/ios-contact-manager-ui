//
//  ContactBook.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import Foundation

struct ContactBook {
    private var personContactList: [Person] = []
}

extension ContactBook {
    mutating func setContactList(_ list: [Person]) {
        self.personContactList = list
        sortContactList()
    }
    
    mutating func addPersonContact(_ person: Person) {
        let isDuplicated = hasDuplicates(person)

        if isDuplicated {
            return
        } else {
            self.personContactList.append(person)
            sortContactList()
        }
    }
    
    mutating func deletePersonContact(_ indexPath: IndexPath) {
        self.personContactList.remove(at: indexPath.row)
    }
    
    mutating func updateContactList(_ indexPath: IndexPath, _ person: Person) {
        let isDuplicated = hasDuplicates(person)

        if isDuplicated {
            return
        } else {
            self.personContactList[indexPath.row] = person
            sortContactList()
        }
    }
    
    private mutating func sortContactList() {
        self.personContactList.sort { $0.name.uppercased() < $1.name.uppercased() }
    }
}

extension ContactBook {
    func rowCountContactList() -> Int {
        return self.personContactList.count
    }
    
    func bringPersonContact(_ indexPath: IndexPath) -> Person {
        return self.personContactList[indexPath.row]
    }
    
    private func hasDuplicates(_ contact: Person) -> Bool {
        if self.personContactList.contains(where: ({ $0.name == contact.name && $0.age == contact.age && $0.digits == contact.digits })) {
            return true
        } else {
            return false
        }
    }
}
