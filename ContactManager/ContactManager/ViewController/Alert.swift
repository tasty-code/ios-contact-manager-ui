//
//  Alert.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/9/24.
//

import UIKit

extension UIViewController {
    
    func showConfirmationAlert(title: String, message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "아니오", style: .cancel)
        let confirmationAction = UIAlertAction(title: "예", style: .default ,handler: action)
        confirmationAction.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(confirmationAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alertController, animated: true)
    }
}
