//
//  StringExtension.swift
//  ios-contact-manager-ui
//
//  Created by 동준 on 10/11/23.
//

import Foundation

extension String {
    func formattingPhoneNumber(divider: Character) -> String {
        let count = self.count
        var temp = self
        
        switch count {
        case 3...5:
            temp.insert(divider, at: temp.index(temp.startIndex, offsetBy: 2))
        case 6...9:
            temp.insert(divider, at: temp.index(temp.startIndex, offsetBy: 2))
            temp.insert(divider, at: temp.index(temp.endIndex, offsetBy: 5 - count))
        case 10:
            temp.insert(divider, at: temp.index(temp.startIndex, offsetBy: 3))
            temp.insert(divider, at: temp.index(temp.endIndex, offsetBy: 6 - count))
        case 11:
            temp.insert(divider, at: temp.index(temp.startIndex, offsetBy: 3))
            temp.insert(divider, at: temp.index(temp.endIndex, offsetBy: -4))
        default:
            break
        }
        return temp
    }
}
