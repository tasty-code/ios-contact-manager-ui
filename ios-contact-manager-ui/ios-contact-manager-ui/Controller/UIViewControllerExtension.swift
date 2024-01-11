//
//  UIViewControllerExtension.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/11/24.
//

import UIKit

extension UIViewController {
    func makeCancelAlert(title: String? = nil,
                          message: String,
                          destructiveAction: ((UIAlertAction) -> Void)?,
                          cancelAction: ((UIAlertAction) -> Void)? = nil,
                          completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let destruction = UIAlertAction(title: "예", style: .destructive, handler: destructiveAction)
        alertViewController.addAction(destruction)

        let cancellation = UIAlertAction(title: "아니오", style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancellation)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
