//
//  InputErrorMessage.swift
//  ContactManager
//
//  Created by Blu on 2023/02/09.
//

import Foundation

enum InputErrorMessage: String, CustomStringConvertible, CaseIterable {
    case invalidName = "입력한 이름 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
    case invalidAge = "입력한 나이 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"
    case invalidPhoneNumber = "입력한 연락처 정보가 잘못되었습니다. 입력 형식을 확인해주세요.\n"

    var description: String {
        return self.rawValue
    }
}
