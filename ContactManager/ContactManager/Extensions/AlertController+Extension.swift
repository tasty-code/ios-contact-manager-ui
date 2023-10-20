import UIKit

extension UIAlertController {
    func configureAlertController(title: String, message: String?, defaultAction: String, destructiveAction: String?, viewController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        if let destructiveAction = destructiveAction {
            configureAlertAction(of: alertController, defaultAction, destructiveAction, viewController)
            viewController.present(alertController, animated: true)
        } else {
            configureAlertAction(of: alertController, defaultAction)
            viewController.present(alertController, animated: true)
        }
    }
    
    func configureAlertAction(of alertController: UIAlertController, _ defaultAction: String) {
        alertController.addAction(configureDefaultAlertAction(title: defaultAction))
    }
    
    func configureAlertAction(of alertController: UIAlertController, _ defaultAction: String, _ destructiveAction: String, _ viewController: UIViewController) {
        alertController.addAction(configureDefaultAlertAction(title: defaultAction))
        alertController.addAction(configureDestructiveAlertAction(title: destructiveAction, viewController))
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
