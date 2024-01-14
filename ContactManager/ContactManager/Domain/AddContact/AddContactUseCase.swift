//
//  AddContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

struct AddContactUseCase {
    private let repository: ContactRepository
    
    private let factory: ContactMakable
    
    weak var presenter: AddContactPresentable?
    
    init(
        repository: ContactRepository,
        factory: ContactMakable
    ) {
        self.repository = repository
        self.factory = factory
    }
    
    func saveNewContact(request: AddContact.Request) {
        do {
            let contact = try factory.makeContact(from: request)
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
