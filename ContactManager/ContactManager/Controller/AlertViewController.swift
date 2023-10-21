//
//  AlertViewController.swift
//  ContactManager
//
//  Created by Rarla on 2023/10/13.
//

import UIKit

final class AlertViewController: UIAlertController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  static func show(on viewController: UIViewController, message: String, defaultButtonTitle: String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    let alertOkAction = UIAlertAction(title: defaultButtonTitle, style: .default)
    alert.addAction(alertOkAction)
    
    viewController.present(alert, animated: true)
  }
  
  static func show(on viewController: UIViewController, message: String, defaultButtonTitle: String, destructiveButtonTitle: String,  destructiveAction: @escaping () -> ()) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
    
    let alertOkAction = UIAlertAction(title: defaultButtonTitle, style: .default)
    alert.addAction(alertOkAction)
    
    let alertNoAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { _ in
      destructiveAction()
    }
    alert.addAction(alertNoAction)
    
    viewController.present(alert, animated: true)
  }
}
