//
//  CustomAlert.swift
//  ContactManager
//
//  Created by 유니 & L on 1/12/24.
//

import UIKit

extension CustomAlert where Self: UIViewController { 
    func showAlert(message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
