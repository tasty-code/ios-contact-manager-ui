//
//  ContactManagerError.swift
//  ContactManager
//
//  Created by 유니 & L on 1/5/24.
//

import Foundation

enum ContactManagerError: LocalizedError {
    case fileNotFound
    case indexNotFound
    
    var errorDescription: String {
        switch self {
        case .fileNotFound:
            return "File Not Found Error"
        case .indexNotFound:
            return "Index Not Found Error"
        }
    }
}
