//
//  ListContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct ListContactUseCase {
    private let repository: ContactRepository
    
    weak var presenter: ListContactPresentable?
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func fetchAllContacts() {
        do {
            let contacts = try repository.requestContacts()
            let successInfo = ListContact.SuccessInfo(contacts: contacts)
            presenter?.presentListContact(result: .success(successInfo))
        } catch {
            presenter?.presentListContact(result: .failure(error))
        }
    }
    
    func deleteContact(at index: Int) {
        do {
            try repository.removeContact(at: index)
            presenter?.presentDeleteContact(result: .success(()))
        } catch {
            presenter?.presentDeleteContact(result: .failure(error))
        }
    }
    
    func searchContact(with query: String) {
        let queries = query.components(separatedBy: .whitespacesAndNewlines)
        do {
            let matchingContacts = try repository.searchContact(with: queries)
            let successInfo = ListContact.SuccessInfo(contacts: matchingContacts)
            presenter?.presentSearchContact(result: .success(successInfo))
        } catch {
            presenter?.presentSearchContact(result: .failure(error))
        }
    }
}

import Foundation

protocol ListContactPresentable: NSObjectProtocol {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>)
    func presentDeleteContact(result: Result<Void, Error>)
    func presentSearchContact(result: Result<ListContact.SuccessInfo, Error>)
}
