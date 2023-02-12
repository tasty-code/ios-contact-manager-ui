//
//  DataManager.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    private var contacts: Set<Person> = Set<Person>()
        
    private init() { }
    
    func setContact(_ person: Person) {
        contacts.insert(person)
    }
    
    func setStoredContact(_ data: Set<Person>) {
        contacts = data
    }
    
    func getContactsData() -> Set<Person> {
        return contacts
    }
    
    func getContacts() -> [Person] {
        let datas = contacts.map { $0 }
        return datas
    }
    
    func getContactsList() -> [String] {
        let contacts = contacts.map { "- \($0.name) / \($0.age) / \($0.phoneNum)" }
        return contacts
    }
    
    func countContactLists() -> Int {
        return contacts.count
    }
    
    func deleteContact(of data: Person) {
        contacts.remove(data)
    }
}
