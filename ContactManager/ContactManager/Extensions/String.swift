//
//  String.swift
//  ContactManager
//
//  Created by Janine on 2023/10/11.
//

import Foundation

extension String {
    enum TextFormatType {
        case phoneNum
        case compress
    }
    
    func formatter(type: TextFormatType) -> String {
        switch type {
        case .phoneNum:
            return phoneNumFomatter(self)
        case .compress:
            return self.replacingOccurrences(of: " ", with: "")
        }
    }
    
    func removeSuffix(with character: String) -> String {
        var copy = self
        if copy.hasSuffix(character) {
            copy.removeLast()
        }
        copy.removeLast()
        return String(copy)
    }
    
    private func phoneNumFomatter(_ target: String) -> String {
        let sanitizedTarget = target.replacingOccurrences(of: "-", with: "")
        let offset = sanitizedTarget.hasPrefix("02") ? 1 : 2
        var splited = Array(sanitizedTarget).map { String($0) }

        switch sanitizedTarget.count {
        case 0..<offset + 1:
            break
        case offset + 1..<offset + 4:
            splited[offset] += "-"
            break
        case offset + 4..<offset + 8:
            splited[offset] += "-"
            splited[offset + 3] += "-"
            break
        default:
            splited[offset] += "-"
            splited[offset + 4] += "-"
            break
        }
        
        return splited.joined()
    }
}
