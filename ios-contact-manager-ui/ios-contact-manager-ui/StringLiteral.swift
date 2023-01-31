//
//  StringLiteral.swift
//  ios-contact-manager
//
//  Created by sei_dev on 12/21/22.
//

import Foundation

enum StringLiteral {
    enum Menu {
        static let start = """
            1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료
            메뉴를 선택해주세요 :
            """
        static let wrong = "선택이 잘못되었습니다. 확인 후 다시 입력해주세요."
        static let end = "[프로그램 종료]"
    }
    
    enum Contact {
        static let add = "연락처 정보를 입력해주세요 : "
        static let find = "연락처에서 찾을 이름을 입력해주세요 : "
        static func notFound(name: String) -> String {
            return "연락처에 \(name) 이(가) 없습니다."
        }
        static func added(_ newContact: String) -> String {
            return "입력한 정보는 \(newContact) 입니다."
        }
        static let empty = "입력된 연락처가 없습니다."
        static let exist = "동일한 연락처가 존재합니다. 다른 연락처를 입력해주세요."
    }
}
