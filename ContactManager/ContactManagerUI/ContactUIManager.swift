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
    
    init(validator: ValidatorProtocol) {
        self.validator = validator
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
    
    func getStoredContactsData() {
        dataManager.getStoredContactsData()
    }
    
    func setStoredContactsData() {
        dataManager.setStoredContactsData()
    }
    
    func setContactData(_ userInputModel: UserInputModel) throws {
        let contactData = try requestValidation(with: userInputModel)
        dataManager.setContact(contactData)
    }
    
    func deleteContactData(of data:Person) {
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

// for test
extension ContactUIManager {
    func clearAllStoredDataForTest() {
        dataManager.clearAllStoredDataForTest()
    }
}
