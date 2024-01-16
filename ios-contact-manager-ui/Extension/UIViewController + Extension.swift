//
//  UIViewController + Extension.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 08/01/2024.
//

import UIKit


// MARK: - 스토리보드 Identifier 오타 방지 코드
extension UIViewController {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}

//MARK: - Alert 재사용 method 구현
extension UIViewController {
    /// 확인버튼 하나만 있는 Alert 메서드
    func presentAlert(title: String,
                      message: String,
                      confirmTitle: String,
                      confirmAction: ((UIAlertAction) -> Void)? = nil,
                      completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default)
        alertViewController.addAction(confirmAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 확인, 취소 버튼이 있는 Alert 메서드
    func presentAlertWithCancel(title: String,
                                message: String,
                                cancelTitle: String,
                                confirmTitle: String,
                                confirmAction: ((UIAlertAction) -> Void)? = nil,
                                cancelAction: ((UIAlertAction) -> Void)? = nil,
                                completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .destructive, handler: confirmAction)
        alertViewController.addAction(confirmAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    /// 텍스트 필드 및 확인, 취소 버튼이 있는 Alert 메서드
    func presentAlertWithTextfieldAndCancel(title: String,
                                            message: String,
                                            placeholder: String,
                                            confirmTitle: String,
                                            cancelTitle: String,
                                            confirmAction: ((String) -> Void)? = nil,
                                            cancelAction: ((UIAlertAction) -> Void)? = nil,
                                            completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertViewController.addTextField { textField in
            textField.placeholder = "\(placeholder)"
        }
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            if let text = alertViewController.textFields?.first?.text {
                confirmAction?(text)
            }
        }
        alertViewController.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
