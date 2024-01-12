//
//  String+.swift
//  ios-contact-manager-ui
//
//  Created by Lee minyeol on 1/11/24.
//

import Foundation

extension String {
    var removeBlank: String {
        let blanck = self
        let name = blanck.split(separator: " ").reduce("") { $0 + $1 }
        
        return name
    }
    
    public var formmater: String {
        var stringWithhypen: String = self
        
        switch stringWithhypen.count {
        case 3...5:
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 2))
        case 6...9:
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 2))
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: 5 - count))
        case 10:
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 3))
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: -4))
        case 11:
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 3))
            stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: -4))
        default:
            break
        }
        
        return stringWithhypen
    }
}
