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
        insert(newElement, at: index(startIndex, offsetBy: i))
    }
}
