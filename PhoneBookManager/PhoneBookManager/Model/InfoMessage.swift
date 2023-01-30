//
//  InfoMessage.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/29.
//

import Foundation

enum InfoMessage {
    static let requestMenuInput = "\n1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료\n메뉴를 선택해주세요 : "
    static let requestSearchContact = "연락처에서 찾을 이릅을 입력해주세요 : "
    static let requestAddContact = "연락처 정보를 입력해주세요 : "
    static let contactAlreadyExists = "이미 존재하는 연락처입니다"
    static let emptyContact = "입력된 연락처가 없습니다."
    
    static func noSearchedContact(for name: String) -> String {
        return "연락처에 \(name) 이(가) 없습니다."
    }
}
