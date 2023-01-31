//
//  Enums.swift
//  contactManager
//
//  Created by 김용재 on 2023/01/31.
//

import Foundation

enum GuideText {
   static let menu = "1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료"
   static let selectMenu = "메뉴를 선택해주세요 : "
}

enum MenuType: String {
    case addContact = "1"
    case viewContactList = "2"
    case findContact  = "3"
    case exit = "x"
}
