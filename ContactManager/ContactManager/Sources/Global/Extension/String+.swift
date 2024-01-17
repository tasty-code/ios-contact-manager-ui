//
//  String+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/11.
//

import Foundation

extension String {
    
    /// 공백 삭제한 문자열 반환하는 메서드
    func deleteWhiteSpace() -> String {
        return self.filter { $0 != " " }.map { String($0) }.joined()
    }
}
