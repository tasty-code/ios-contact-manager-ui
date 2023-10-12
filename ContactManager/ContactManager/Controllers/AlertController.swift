import UIKit

extension UIAlertController {
    
    func configureAlertController(title: String, message: String?, firstAction: String, secondAction: String?, viewController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        if let secondAction = secondAction {
            configureAlertAction(of: alertController, firstAction, secondAction, viewController)
            viewController.present(alertController, animated: true)
        } else {
            configureAlertAction(of: alertController, firstAction)
            viewController.present(alertController, animated: true)
        }
    }
    
    func configureAlertAction(of alertController: UIAlertController, _ firstAction: String) {
        alertController.addAction(configureDefaultAlertAction(title: firstAction))
    }
    
    func configureAlertAction(of alertController: UIAlertController, _ firstAction: String, _ secondAction: String, _ viewController: UIViewController) {
        alertController.addAction(configureDefaultAlertAction(title: firstAction))
        alertController.addAction(configureDestructiveAlertAction(title: secondAction, viewController))
    }
    
    func configureDestructiveAlertAction(title: String, _ viewController: UIViewController) -> UIAlertAction {
        let destructiveAlertAction = UIAlertAction(title: title, style: .destructive, handler: { _ in
            viewController.dismiss(animated: true)
        })
        
        return destructiveAlertAction
    }
    
    func configureDefaultAlertAction(title: String) -> UIAlertAction {
        let defaultAlertAction = UIAlertAction(title: title, style: .default, handler: nil)
        
        return defaultAlertAction
    }
}
