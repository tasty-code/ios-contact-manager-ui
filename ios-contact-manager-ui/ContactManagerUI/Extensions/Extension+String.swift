//
//  Extension+String.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/10/23.
//

import Foundation

extension String {
    static var hyphen: String {
        return "-"
    }
    static var empty: String {
        return ""
    }

    mutating func insert(_ newElement: Character, at i: Int) {
        self.insert(newElement, at: self.index(self.startIndex, offsetBy: i))
    }

    func inserting(_ newElement: Character, at i: Int) -> String {
        var newString = self
        newString.insert(newElement, at: self.index(self.startIndex, offsetBy: i))
        return newString
    }
}
