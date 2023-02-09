//
//  MenuStart.swift
//  ContactManager
//
//  Created by Jason on 2023/02/09.
//

import Foundation

enum MenuStart: String, CustomStringConvertible {
    case addContact = "1"
    case viewContact = "2"
    case searchContact = "3"
    case exit = "x"
    
    var description: String {
        return self.rawValue
    }
}
