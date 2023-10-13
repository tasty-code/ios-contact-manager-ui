//
//  AlertViewController.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/13.
//

import UIKit

class AlertViewController: UIAlertController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func showAlert(_ data: AlertData) {
    let alert = UIAlertController(title: "", message: data.message, preferredStyle: UIAlertController.Style.alert)
    let alertOkAction = UIAlertAction(title: data.defaultButtonTitle, style: .default)
    alert.addAction(alertOkAction)
    if let destructiveButtonTitle = data.destructiveButtonTitle {
      let alertNoAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { _ in
        data.destructiveAction?()
      }
      alert.addAction(alertNoAction)
    }
    data.viewController.present(alert, animated: true)
  }
}
