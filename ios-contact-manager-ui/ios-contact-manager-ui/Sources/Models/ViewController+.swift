//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/8/24.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String?, _ error: Error?, actions: [UIAlertAction]) -> UIAlertController {
        let message = error == nil ? "" : String(describing: error)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
