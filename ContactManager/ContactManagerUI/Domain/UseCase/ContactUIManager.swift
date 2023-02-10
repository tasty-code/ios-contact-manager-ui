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
            return getContactsData()
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
                self.dataManager.contacts = Set(decodedData)
            }
        }
    }
    
    func setStoredContactsData() {
        let data = dataManager.getcontactsDataAsPerson()
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
    
    func getContactsData() -> [Person]  {
        let persons = dataManager.getcontactsDataAsPerson()
        return persons
    }
    
    func formmatingPhoneNumber(with number: String?) -> String? {
        guard let number = number else { return nil }
        
        let numberWithNoHyphen = number.split(separator: "-").joined()
        var phoneNumber = numberWithNoHyphen.map { String($0) }
        
        switch phoneNumber.count {
        case 0..<3:
            return phoneNumber.joined()
        case 3..<6:
            phoneNumber.insert("-", at: 2)
            return phoneNumber.joined()
        case 6..<10:
            phoneNumber.insert("-", at: 2)
            phoneNumber.insert("-", at: 6)
            return phoneNumber.joined()
        default:
            phoneNumber.insert("-", at: 3)
            phoneNumber.insert("-", at: 8)
            return phoneNumber.joined()
        }
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
