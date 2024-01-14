//
//  AddContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

struct AddContactUseCase {
    private let repository: ContactRepository
    
    weak var presenter: AddContactPresentable?
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func saveNewContact(request: AddContact.Request) {
        do {
            #warning("validation + conversion 구현")
            guard let age = Int(request.age) else { 
                throw AgeValidationError.cannotStartWithZero
            }
            
//            let contact = Contact(
//                name: request.name,
//                phoneNumber: request.phoneNumber,
//                age: age
//            )
            let contact = Contact(
                name: "Hong",
                phoneNumber: "010-1010-1010",
                age: 10
            )
            try repository.addContact(contact)
            presenter?.presentAddContact(result: .success(.init()))
        } catch {
            presenter?.presentAddContact(result: .failure(error))
        }
    }
}

enum AddContact {
    struct Request {
        let name: String
        let age: String
        let phoneNumber: String
    }
    
    struct SuccessInfo {
        
    }
}

import Foundation

protocol AddContactPresentable: NSObjectProtocol {
    func presentAddContact(result: Result<AddContact.SuccessInfo, Error>)
}
