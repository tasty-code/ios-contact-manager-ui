//
//  ContactUIManager.swift
//  ContactManagerUI
//
//  Created by devxsby on 2023/02/06.
//

import Foundation

protocol ContactUIManagerProtocol {
    func runProgram(menu: Menu)
}

final class ContactUIManager: ContactUIManagerProtocol {
    
    var validator: ValidateUIProtocol
    private let dataManager = DataManager.shared
    
    init(validator: ValidateUIProtocol) {
        self.validator = validator
    }
    
    func runProgram(menu: Menu) {
        // menu
    }
}

extension ContactUIManager {
    
    func addProgram() {
        
    }
    
    func showListProgram() -> [Person]  {
       return []
    }
    
}
