//
//  Extension.swift
//  ios-contact-manager
//
//  Created by 송선진 on 2022/12/23.
//

import Foundation

extension String {
    static func ~= (_ lhs: String, _ rhs: String) -> Bool {
        return lhs.range(of: rhs, options: .regularExpression) != nil
    }
    
    func matches(infoType: UserInfoParameters) throws -> String {
        guard self ~= infoType.regex else {
            throw infoType.error
        }
        return self
    }
}
