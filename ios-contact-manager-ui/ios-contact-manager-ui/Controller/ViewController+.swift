//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/8/24.
//

import UIKit

extension UIViewController {
    func showErrorAlert(title: String?, _ error: Error?, action: UIAlertAction) -> UIAlertController {
        let alert = UIAlertController(title: title, message: String(describing: error!), preferredStyle: .alert)
        alert.addAction(action)
        return alert
    }
}
