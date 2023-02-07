//
//  ContactUIManager.swift
//  ContactManagerUI
//
//  Created by devxsby on 2023/02/06.
//

import Foundation

protocol ContactUIManagerProtocol {
    func runProgram(menu: Menu, data: UserInputModel?) throws -> Any?
}

final class ContactUIManager: ContactUIManagerProtocol {
    
    var validator: ValidateUIProtocol
    private let dataManager = DataManager.shared
    
    init(validator: ValidateUIProtocol) {
        self.validator = validator
    }
    
    @discardableResult
    func runProgram(menu: Menu, data: UserInputModel? = nil) throws -> Any? {
        guard let data else { return nil }
        switch menu {
        case .add:
            try addProgram(data)
        case .showList:
            return showListProgram()
        default:
            throw Errors.readFail
        }
        return nil
    }
}

extension ContactUIManager {
    
    func addProgram(_ data:UserInputModel) throws {
        try self.validateData(with: data)
        guard let validatedData = data.convertToPerson() else { throw Errors.readFail }
        dataManager.setContact(validatedData)
    }
    
    func showListProgram() -> [Person]  {
        let persons = dataManager.getContactsData().map{$0}
        return persons
    }
    
    private func validateData(with:UserInputModel) throws {
        
    }
    
}
