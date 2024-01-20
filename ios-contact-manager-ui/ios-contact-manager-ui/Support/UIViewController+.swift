
import UIKit

extension UIViewController {
    func showMessageAlert(title: String? = nil,
                                 message: String,
                                 actionList: [UIAlertAction],
                                 completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actionList {
            alertViewController.addAction(action)
        }
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
