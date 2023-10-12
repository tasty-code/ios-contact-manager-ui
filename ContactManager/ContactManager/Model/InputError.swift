//
//  InputError.swift
//  ContactManager
//
//  Created by 전성수 on 10/12/23.
//

import Foundation

enum InputError: Error {
    case name
    case age
    case digits
    case empty
    case exception
}
