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
    
    func fetchContact(request: AddContact.FetchContact.Request) {
        do {
            let id = request.id
            let contact = try self.repository.requestContact(id: id)
            presenter?.presentFetchContact(result: .success(contact))
        } catch {
            presenter?.presentFetchContact(result: .failure(error))
        }
    }
    
    func saveNewContact(request: AddContact.CreatContact.Request) {
        do {
            let contact = try factory.makeContact(from: request)
            try repository.addContact(contact)
            presenter?.presentAddContact(result: .success(()))
        } catch {
            presenter?.presentAddContact(result: .failure(error))
        }
    }
    
    func updateNewContact(request: AddContact.UpdateContact.Request) {
        do {
            let contact = try factory.makeExistingContact(from: request)
            try repository.updateContact(with: contact)
            presenter?.presentUpdateContact(result: .success(()))
        } catch {
            presenter?.presentUpdateContact(result: .failure(error))
        }
    }
    
    func confirmCancel(request: AddContact.CreatContact.Request) {
        do {
            try confirmIfCancellable(request: request)
            presenter?.presentCancelConfirmation(result: .success(()))
        } catch {
            presenter?.presentCancelConfirmation(result: .failure(error))
        }
    }
    
    private func confirmIfCancellable(request: AddContact.CreatContact.Request) throws {
        guard request.name.isEmpty,
              request.age.isEmpty,
              request.phoneNumber.isEmpty else {
            throw AddContactError.someFieldIsFilled
        }
    }
}

protocol AddContactPresentable: AnyObject {
    func presentFetchContact(result: Result<Contact, Error>)
    func presentAddContact(result: Result<Void, Error>)
    func presentCancelConfirmation(result: Result<Void, Error>)
    func presentUpdateContact(result: Result<Void, Error>)
}
