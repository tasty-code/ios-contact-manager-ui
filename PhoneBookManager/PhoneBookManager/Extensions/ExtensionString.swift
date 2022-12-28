//
//  ExtensionString.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/22.
//

import Foundation

extension String {
    func removeWhiteSpaces() -> String {
        return self.filter { $0 != " " }
    }
    
    func hasWhiteSpace() -> Bool {
        return self.rangeOfCharacter(from: .whitespaces) != nil
    }
    
    func hasWhiteSpaceAtStartOrEnd() -> Bool {
        return self.hasPrefix(" ") || self.hasSuffix(" ")
    }
}
