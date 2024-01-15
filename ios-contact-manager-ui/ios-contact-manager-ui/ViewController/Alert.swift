
import UIKit

struct Alert {
    static func create(title: String, message: String, confirmTitle: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: nil))
        return alert
    }
}
