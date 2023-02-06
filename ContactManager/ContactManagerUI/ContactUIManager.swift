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
        // Save 버튼 눌렀을때 연락처 저장
        print(#function)
        print(data)
        try self.validateData(with: data)
        guard let validatedData = data.convertToPerson() else { throw Errors.readFail }
        dataManager.setContact(validatedData)
    }
    
    func showListProgram() -> [Person]  {
        // 테이블뷰에 저장된 연락처 출력
        let personSets = dataManager.getContactsData()
        let persons = personSets.map{$0}
        return persons
    }
    
    private func validateData(with:UserInputModel) throws {
        
    }
    
}
