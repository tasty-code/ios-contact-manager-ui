
import UIKit

extension UIViewController {
    func setStatusBar() {
        let statusBarsize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarsize)
        let statusBarView = UIView(frame: frame)
        
        statusBarView.backgroundColor = .lightGray
        view.addSubview(statusBarView)
    }
}
