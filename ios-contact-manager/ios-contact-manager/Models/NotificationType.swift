//
//  NotificationName.swift
//  ios-contact-manager
//
//  Created by Swain Yun on 10/12/23.
//

import Foundation

enum NotificationType {
    case createContact, updateContact
    
    var name: String {
        switch self {
        case .createContact: return "CreateContact"
        case .updateContact: return "UpdateContact"
        }
    }
}
