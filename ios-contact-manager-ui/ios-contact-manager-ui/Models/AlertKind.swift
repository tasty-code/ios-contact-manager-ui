//
//  AlertKind.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/17.
//

import UIKit

enum AlertKind {
    case cancel(title: String, actions: [UIAlertAction])
    case error(type: Error, action: UIAlertAction)
    
    func configureAlertController() -> UIAlertController {
        switch self {
        case .cancel(let title, let actions):
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            for action in actions {
                alert.addAction(action)
            }
            return alert
        case .error(let type, let action):
            let alert = UIAlertController(title: "오류 발생", message: String(describing: type), preferredStyle: .alert)
            alert.addAction(action)
            return alert
        }
    }
}
