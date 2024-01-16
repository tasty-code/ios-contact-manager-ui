//
//  String+.swift
//  ios-contact-manager-ui
//
//  Created by Lee minyeol on 1/11/24.
//

import Foundation

extension String {
    var removeBlank: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var formmater: String {
        var stringWithhypen: String = self
        
        if stringWithhypen.prefix(1) != "0" || stringWithhypen.prefix(2) == "02" {
            switch stringWithhypen.count {
            case 3...5:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 2))
            case 6...8:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 2))
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: 5 - count))
            case 9...10:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 2))
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: -4))
            default:
                break
            }
        }
        
        else {
            switch stringWithhypen.count {
            case 4...6:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 3))
            case 7...9:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 3))
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: 6 - count))
            case 10...11:
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.startIndex, offsetBy: 3))
                stringWithhypen.insert("-", at: stringWithhypen.index(stringWithhypen.endIndex, offsetBy: -4))
            default:
                break
            }
        }
        
        return stringWithhypen
    }
}
