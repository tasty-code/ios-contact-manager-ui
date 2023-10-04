//
//  Contact.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation



struct Contact: Hashable {
    let uuid = UUID()
    private(set) var name: String
    private(set) var age: Int
    private(set) var phoneNumbers = Set<PhoneNumber>()
}


typealias PhoneNumber = String



