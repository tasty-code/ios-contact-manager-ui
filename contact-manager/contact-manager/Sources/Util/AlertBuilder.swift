import UIKit

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let completion: (() -> Void)?
}

final class AlertBuilder {
    private var alertActions: [AlertAction] = []

    func addAction(_ title: String, style: UIAlertAction.Style, action: (() -> Void)? = nil) -> Self {
        let alertAction = AlertAction(title: title, style: style, completion: action)
        alertActions.append(alertAction)
        return self
    }
    
    func addMessage(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertActions.forEach { action in
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.completion?()
            }
            alertController.addAction(alertAction)
        }
        return alertController
    }
}
