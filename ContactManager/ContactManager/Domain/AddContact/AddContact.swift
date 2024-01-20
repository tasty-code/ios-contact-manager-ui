//
//  AddContactModel.swift
//  ContactManager
//
//  Created by Effie on 1/15/24.
//

enum AddContact {
    enum CreatContact {
        struct Request {
            let name: String
            let age: String
            let phoneNumber: String
        }
    }
    
    enum FetchContact {
        struct Request {
            let id: Int
        }
    }
}
