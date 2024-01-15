//
//  ErrorAlertPresentableViewController.swift
//  ContactManager
//
//  Created by Effie on 1/9/24.
//

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

protocol ErrorAlertPresentableViewController {
    func presentErrorAlert(
        error: AlertableError,
        additionalAction: UIAlertAction...
    )
}

extension ErrorAlertPresentableViewController where Self: UIViewController {
    func presentErrorAlert(
        error: AlertableError,
        additionalAction: UIAlertAction...
    ) {
        let alertController = UIAlertController(
            title: error.alertConfig.title,
            message: error.alertConfig.body,
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(
            title: error.alertConfig.okActionTitle,
            style: .default
        )
        alertController.addAction(defaultAction)
        
        for action in additionalAction {
            alertController.addAction(action)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
}
