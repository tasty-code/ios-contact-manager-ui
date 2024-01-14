//
//  AddContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

struct AddContactUseCase {
    private let repository: ContactRepository
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func saveNewContact(request: AddContact.Request) {
        do {
            #warning("구현 수정")
            // validation
            // conversion
            guard let age = Int(request.age) else { throw ContactValidateError.invalidName }
            let contact = Contact(name: request.name, phoneNumber: request.phoneNumber, age: age)
            try repository.addContact(contact)
        } catch {
            print(error.localizedDescription)
        }
    }
}

enum AddContact {
    struct Request {
        let name: String
        let age: String
        let phoneNumber: String
    }
}
