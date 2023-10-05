//
//  ContactBook.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import Foundation

struct ContactBook {
    private var contactInfomation: [[Person]]
    
    func showContactList(_ indexPath: IndexPath) -> Person {
        return contactInfomation[indexPath.section][indexPath.row]
    }
    
    func addContactList() {
        
    }
    
    func deleteContactList() {
        
    }
    
    func updateContactList() {
        
    }
}
