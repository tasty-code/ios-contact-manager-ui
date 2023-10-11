//
//  ContactValidityChecker.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/11.
//

import Foundation

struct ContactValidityChecker {
    func checkNameValidation(_ name: String) -> String? {
        let subSpaceName = name.trimmingCharacters(in: [" "])
        
        if subSpaceName.count == 0 {
            return nil
        }
        
        return subSpaceName
    }
    
    func checkAgeValidation(_ age: String) -> Int? {
        let subSpaceAge = age.trimmingCharacters(in: [" "])
        
        if subSpaceAge.count == 0 {
            return nil
        }
        
        guard let validAge = Int(subSpaceAge), (1..<100).contains(validAge)
        else {
            return nil
        }
        
        return validAge
    }
    
    func checkPhoneNumberValidation(_ phoneNumber: String) -> String? {
        guard let _ = try? /^\d{1,9}-\d{1,9}-\d{1,9}$/.wholeMatch(in: phoneNumber)
        else {
            return nil
        }
        
        return phoneNumber
    }
}
