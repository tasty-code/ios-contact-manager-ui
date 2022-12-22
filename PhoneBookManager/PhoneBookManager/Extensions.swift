//
//  Extensions.swift
//  PhoneBookManager
//
//  Created by Mason Kim on 2022/12/22.
//

import Foundation

extension String {
    func removingWhiteSpaces() -> String {
        return self.filter { $0 != " " }
    }

    func splitBySlash() -> [String] {
        return self.split(separator: "/").map { String($0) }
    }
}
