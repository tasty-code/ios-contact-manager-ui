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
    
    /// 핸드폰 번호 형식인지 검사하는 메서드
    func validatePhoneNumberFormat() -> Bool {
        let regex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: self)
    }
    
    /// 일반 전화 형식인지 검사하는 메서드
    func validateContactNumberFormat() -> Bool {
        let regex = "^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])-([0-9]{3,4})-([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: self)
    }
    
}
