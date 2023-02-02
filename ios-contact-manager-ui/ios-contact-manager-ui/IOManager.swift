//
//  IOManager.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/22.
//

import Foundation

enum PrintType {
    case menu
    case infomation
    case error
}

enum IOManager {
    static func getInput() throws -> String {
        guard let input = readLine(),
              input != "" else {
            throw IOError.emptyInput
        }
        
        return input
    }
    
    static func sendOutput(type: PrintType, contents: String) {
        switch type {
        case .menu:
            print("🖥️ \(contents)")
        case .infomation:
            print("🤔 \(contents)")
        case .error:
            print("❌ \(contents)")
        }
    }
}
