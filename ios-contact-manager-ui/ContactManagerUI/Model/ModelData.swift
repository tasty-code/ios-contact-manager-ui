//
//  ModelData.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

final class ModelData: JSONCodable {
    var fileName: String = "contacts.json"
    private lazy var contacts: [UserInfo] = decoding()
}

extension ModelData {
    func decoding() -> [UserInfo] {
        do {
            return try decoder()
        } catch {
            return []
        }
    }
    
    func load() -> [UserInfo] {
        return contacts
    }
    
    func save(data: [UserInfo]) {
        do {
            try encoder(data: data)
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

