//
//  ContactUIManager.swift
//  ContactManagerUI
//
//  Created by devxsby on 2023/02/06.
//

import Foundation

protocol ContactUIManagerProtocol {
    func runProgram(menu: Menu, userInputModel: UserInputModel?) throws -> Any?
}

final class ContactUIManager: ContactUIManagerProtocol {
    
    var validator: ValidatorProtocol
    private let dataManager = DataManager.shared
    private var dataStore = UserDefaults.standard
    
    init(validator: ValidatorProtocol) {
        self.validator = validator
        self.getStoredContactsData()
    }
    
    @discardableResult
    func runProgram(menu: Menu, userInputModel: UserInputModel?) throws -> Any? {
        guard let userInputModel else { return nil }
        
        switch menu {
        case .add:
            try setContactData(userInputModel)
        case .showList:
            return getSortedContacts()
        default:
            throw Errors.readFail
        }
        return nil
    }
    
}

extension ContactUIManager {
    
    private func getStoredContactsData(){
        if dataStore.object(forKey: UserDefaults.Keys.contacts) != nil {
            if let data = dataStore.value(forKey: UserDefaults.Keys.contacts) as? Data {
                guard let decodedData = try? PropertyListDecoder().decode([Person].self, from: data) else { return }
                self.dataManager.setStoredContact(Set(decodedData))
            }
        }
    }
    
    func setStoredContactsData() {
        let data = dataManager.getContacts()
        let encodedData = try? PropertyListEncoder().encode(data)
        dataStore.set(encodedData, forKey: UserDefaults.Keys.contacts)
    }
    
    private func setContactData(_ userInputModel: UserInputModel) throws {
        let contactData = try requestValidation(with: userInputModel)
        dataManager.setContact(contactData)
    }
    
    func deleteContactData(of data: Person) {
        dataManager.deleteContact(of: data)
    }
    
    func getSortedContacts() -> [Person]  {
        let persons = dataManager.getContacts().sorted{ lhs, rhs in
            if lhs.name != rhs.name {
                return lhs.name < rhs.name
            } else if lhs.name == rhs.name {
                return lhs.age < rhs.age
            } else {
                return lhs.phoneNum < rhs.phoneNum
            }
        }
        return persons
    }
    
    func countContactLists() -> Int {
        return dataManager.countContactLists()
    }
    
    private func requestValidation(with userInputModel: UserInputModel) throws -> Person {
        do {
            let person = try validator.checkValidFormat(input: userInputModel)
            return person
        } catch {
            throw error
        }
    }
}
