//
//  Menu.swift
//  ContactManager
//
//  Created by devxsby on 2023/01/30.
//

import Foundation

enum Menu: String, CaseIterable {
    case add = "1"
    case showList = "2"
    case search = "3"
    case exit = "x"
        
    var description: String {
        switch self {
        case .add:
            return "연락처 추가"
        case .showList:
            return "연락처 목록보기"
        case .search:
            return "연락처 검색"
        case .exit:
            return "종료"
        }
    }
    
    static var greeting: String {
        return Menu.allCases.map { "\($0.rawValue)) \($0.description) " }.joined()
    }
}
