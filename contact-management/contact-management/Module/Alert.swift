//
//  Alert.swift
//  contact-management
//
//  Created by Roh on 1/14/24.
//

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

enum Alert {
    case stopEditContact(AlertActionHandler)
    // MARK: 이번 케이스에서는 "saveEditContact" 사용 x
    case saveEditContact
    case inCorrectName
    case inCorrectAge
    case inCorrectPhone
    
    var title: String {
        switch self {
        case .stopEditContact:
            return "정말로 취소하시겠습니까?"
        case .saveEditContact:
            return ""
        case .inCorrectName:
            return "입력된 이름 정보가 잘못되었습니다"
        case .inCorrectAge:
            return "입력된 나이 정보가 잘못되었습니다"
        case .inCorrectPhone:
            return "입력된 연락처 정보가 잘못되었습니다"
        }
    }
    var body: String {
        ""
    }
    
    var alertController: UIAlertController {
        let alertController = UIAlertController(
            title: self.title,
            message: self.body,
            preferredStyle: .alert
        )
        
        switch self {
        case .stopEditContact(let action):
            alertController.addAction(UIAlertAction(
                title: "예",
                style: .default,
                handler: action
            ))
            alertController.addAction(UIAlertAction(title: "아니요", style: .cancel))
            return alertController
       
        case .saveEditContact:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .inCorrectName:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .inCorrectAge:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .inCorrectPhone:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
        }
    }
}
