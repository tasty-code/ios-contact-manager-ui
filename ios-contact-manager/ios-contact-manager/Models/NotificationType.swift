//
//  NotificationType.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/12/23.
//

import Foundation

enum NotificationType {
    case contactsDidChange
    
    var name: String {
        switch self {
        case .contactsDidChange: return "ContactsDidChange"
        }
    }
}
