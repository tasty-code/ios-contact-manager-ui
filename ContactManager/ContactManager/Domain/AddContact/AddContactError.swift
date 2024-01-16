//
//  AddContactError.swift
//  ContactManager
//
//  Created by Effie on 1/15/24.
//

enum AddContactError: Error, AlertableError {
    case someFieldIsFilled
    
    var alertConfig: ErrorAlertConfig {
        switch self {
        case .someFieldIsFilled:
            return .init(
                body: "작성 중인 내용이 있습니다.\n정말 작업을 취소하시겠습니까?",
                okActionTitle: "돌아가기"
            )
        }
    }
}
