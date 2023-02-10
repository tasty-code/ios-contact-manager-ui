//
//  ContactsController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

final class ContactsController: JSONCodable {
    static let shared = ContactsController()
    private init() { }

    var fileName: String {
        return "contacts.json"
    }
    private(set) lazy var contacts: [UserInfo] = decoding()
}

extension ContactsController {
    private func decoding() -> [UserInfo] {
        do {
            return try decoder()
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    func save() {
        do {
            try encoder(data: contacts)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(user: UserInfo) {
        contacts.append(user)
    }
    
    func remove(index: Int) {
        contacts.remove(at: index)
    }
}

