//
//  String+Extension.swift
//  ios-contact-manager-ui
//
//  Created by BOMBSGIE on 2023/10/19.
//

import Foundation


extension String {
    func toNameText() -> String {
        return "이름: \(self)"
    }
    
    func toAgeText() -> String {
        return "나이: \(self)"
    }
    
    func toPhoneNumberText() -> String {
        return "연락처: \(self)"
    }
}
