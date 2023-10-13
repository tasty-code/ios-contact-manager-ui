import UIKit

protocol DataSendable: AnyObject {
    func send(textField: [ContactDTO])
}
