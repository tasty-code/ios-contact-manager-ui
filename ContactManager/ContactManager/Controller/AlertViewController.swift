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
  
  func showAlert(self: UIViewController, message: String, defaultButtonTitle: String, destructiveButtonTitle: String? = nil, destructiveAction: (() -> Void)? = nil ) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    
    let alertOkAction = UIAlertAction(title: defaultButtonTitle, style: .default)
    alert.addAction(alertOkAction)
    
    if let destructiveButtonTitle {
      let alertNoAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { _ in
        destructiveAction?()
      }
      alert.addAction(alertNoAction)
    }
    
    self.present(alert, animated: true)
  }
}
