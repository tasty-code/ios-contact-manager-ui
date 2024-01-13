
import UIKit

struct Alert {
    static func create(title: String,with message: String,with confirmTitle: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        return alert
    }
}
