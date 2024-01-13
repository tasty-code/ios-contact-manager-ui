
import UIKit

extension UIViewController {
    public func showMessageAlert(title: String? = nil,
                                 message: String,
                                 okAction: ((UIAlertAction) -> ())? = nil,
                                 completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    public func sureCancelAlert(title: String? = nil,
                             message: String,
                             yesAction: ((UIAlertAction) -> ())? = nil,
                             noAction: ((UIAlertAction) -> ())? = nil,
                             completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "아니오", style: .default, handler: noAction)
        alertViewController.addAction(noAction)
        let yesAction = UIAlertAction(title: "예", style: .destructive, handler: yesAction)
        alertViewController.addAction(yesAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
