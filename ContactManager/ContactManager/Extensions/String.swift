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
        case whiteSpaceRemoval
    }
    
    func formatter(type: TextFormatType) -> String {
        switch type {
        case .phoneNum:
            return phoneNumFomatter(self)
        case .whiteSpaceRemoval:
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
        var splited = Array(sanitizedTarget).map { String($0) }

        switch sanitizedTarget.count {
        case 0..<2:
            break
        case 2..<5:
            splited[1] += "-"
            break
        case 5..<9:
            splited[1] += "-"
            splited[4] += "-"
            break
        case 9..<10:
            splited[2] += "-"
            splited[5] += "-"
            break
        default:
            splited[2] += "-"
            splited[6] += "-"
            break
        }
        
        return splited.joined()
    }
}
