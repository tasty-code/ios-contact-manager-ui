//
//  OutputManager.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/21.
//

import Foundation

enum OutputManager {
    static func printInputMessage() {
        print("연락처 정보를 입력해주세요 : ", terminator: "")
    }

    static func printInitialInputInfo(name: String, age: Int, phoneNumber: String) {
        print("입력한 정보는 \(age)세 \(name)(\(phoneNumber))입니다.")
    }
}
