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
    
    static func printMenuInputMessage() {
        print("1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료")
        print("메뉴를 선택해주세요 : ", terminator: "")
    }
}
