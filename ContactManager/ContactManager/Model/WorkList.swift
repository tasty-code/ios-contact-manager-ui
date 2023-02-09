//
//  MenuStart.swift
//  ContactManager
//
//  Created by Jason on 2023/02/09.
//

import Foundation

enum WorkList: String, CustomStringConvertible {
    case add = "1"
    case view = "2"
    case search = "3"
    case exit = "x"
    
    var description: String {
        return self.rawValue
    }
}
