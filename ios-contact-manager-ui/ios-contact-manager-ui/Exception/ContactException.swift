//
//  ContactException.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import Foundation

enum ContactException: Error, LocalizedError {
    case contactAlreadyExsist(contact: Contact)
    case contactNotFound(contact: Contact)
    
    var errorDescription: String? {
        switch self {
        case .contactAlreadyExsist(let contact):
            return "\(contact.name)는(은) 이미 존재합니다."
        case .contactNotFound(let contact):
            return "\(contact.name)는(은) 존재하지 않습니다."
        }
    }
}
