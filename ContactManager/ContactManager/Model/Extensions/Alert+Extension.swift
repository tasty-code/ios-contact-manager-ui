//
//  CustomAlert.swift
//  ContactManager
//
//  Created by 유니 & L on 1/12/24.
//

import UIKit

extension UIViewController { 
    func showAlertWithConfirmation(message: String, isDestructive: Bool, confirmationAction: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "예", style: isDestructive ? .destructive : .default, handler: confirmationAction))
        alert.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
