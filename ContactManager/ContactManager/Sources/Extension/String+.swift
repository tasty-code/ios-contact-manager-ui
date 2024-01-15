//
//  String+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/11.
//

    import Foundation

extension String {
    
    func deleteWhiteSpace(_ text: String) -> String {
        return self.filter { $0 != " " }.map { String($0) }.joined()
    }
    
    func checkValidityAge() -> Bool {
            let ageCondition = "^[0-9]{1,3}$"
            return self.range(of: ageCondition, options: .regularExpression) != nil
    }
    
    func checkValidityContact() -> Bool {
            let contactCondition = "^(0\\d{1,2}-?)?(\\d{9,})$"
            let checkText = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            return checkText.range(of: contactCondition, options: .regularExpression) != nil
    }
}
