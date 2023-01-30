//
//  DataManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var contacts: Set<Person> = Set<Person>()
    
    func setContact(_ data: Person) {
        contacts.insert(data)
    }
    
    func getContactsData() -> Set<Person> {
        return contacts
    }
    
    func getContactsList() -> [String] {
        
        let contacts = contacts.map{ "- \($0.name) / \($0.age) / \($0.phoneNum)"}
        
        return contacts
    }
    private init() {}
}
