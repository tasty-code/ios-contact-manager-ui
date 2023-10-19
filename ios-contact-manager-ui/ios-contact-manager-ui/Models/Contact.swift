//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import Foundation

typealias ContactInfo = (String, String, String)

final class Contact: Codable, Identifiable {
    private(set) var name: String
    private(set) var age: String
    private(set) var phoneNumber: String
    
    init(info: ContactInfo) {
        self.name = info.0
        self.age = info.1
        self.phoneNumber = info.2
    }
    
    func update(with info: ContactInfo) {
        self.name = info.0
        self.age = info.1
        self.phoneNumber = info.2
    }
}
