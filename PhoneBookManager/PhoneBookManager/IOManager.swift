//
//  IOManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

struct IOManager {
    
    static func userInput() -> String {
        return readLine() ?? ""
    }
    
    static func printInputMessage() {
        print("연락처 정보를 입력해주세요 : ", terminator: "")
    }
    
}
