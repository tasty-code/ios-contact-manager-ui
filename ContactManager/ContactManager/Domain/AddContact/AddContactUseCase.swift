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
    
    func confirmCancel(request: AddContact.Request) {
        do {
            try confirmIfCancellable(request: request)
            presenter?.presentAddContact(result: .success(.init()))
        } catch {
            presenter?.presentAddContact(result: .failure(error))
        }
    }
    
    private func confirmIfCancellable(request: AddContact.Request) throws {
        guard request.name.isEmpty,
              request.age.isEmpty,
              request.phoneNumber.isEmpty else {
            throw AddContactError.someFieldIsFilled
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
    func presentCancelConfirmation(result: Result<AddContact.SuccessInfo, Error>)
}

enum AddContactError: Error, AlertableError {
    case someFieldIsFilled
    
    var alertConfig: ErrorAlertConfig {
        switch self {
        case .someFieldIsFilled:
            return .init(
                body: "작성 중인 내용이 있습니다.\n정말 작업을 취소하시겠습니까?",
                okActionTitle: "돌아가기"
            )
        }
    }
}
