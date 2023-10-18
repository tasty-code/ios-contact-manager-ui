import UIKit

protocol DataSendable: AnyObject {
    func send(_ data: ContactDTO)
}
