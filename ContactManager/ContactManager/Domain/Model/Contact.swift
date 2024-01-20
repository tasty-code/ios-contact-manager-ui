//
//  Contact.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct Contact: Hashable, Decodable {
    let id: Int
    
    let name: String
    
    let phoneNumber: String
    
    let age: Int
}
