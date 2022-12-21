//
//  main.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

struct ContactInfo {
    let name: String
    let age: String
    let phoneNumber: String
}

class ContactManager {
    var contactInfo: [ContactInfo] = []
    
    func contactManager() {
        var isRun: Bool = true
        
        repeat {
            print("연락처 정보를 입력해주세요:")
            guard let userInput: String? = readLine() else {
                continue
            }
            print(userInput)
        } while isRun
    }
}
