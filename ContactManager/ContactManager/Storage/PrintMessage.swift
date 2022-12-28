//
//  PrintMessage.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/21.
//

import Foundation

enum PrintMessage: String, CustomStringConvertible {
    case startComment = "연락처 정보를 입력해주세요 : "
    case correctContactInfo = "입력한 정보는 "
    case invalidName = "입력한 이름 정보가 잘못되었습니다. 입력 형식을 확인해주세요."
    case invalidAge = "입력한 나이 정보가 잘못되었습니다. 입력 형식을 확인해주세요."
    case invalidPhoneNumber = "입력한 연락처 정보가 잘못되었습니다. 입력 형식을 확인해주세요."
    case nothingUserInput = "아무것도 입력되지 않았습니다. 입력 형식을 확인해주세요."
    
    static func validUserInput(value: [String]) -> Bool {
        let name = value[0]
        let age = value[1]
        let phoneNumber = value[2]
        print(PrintMessage.correctContactInfo, terminator: "")
        print("\(name)세 \(age)(\(phoneNumber))입니다. \n")
        return true
    }
    
    var description: String {
        return self.rawValue
    }
}
