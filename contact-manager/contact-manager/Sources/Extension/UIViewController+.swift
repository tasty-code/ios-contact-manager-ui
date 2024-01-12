import UIKit

extension UIViewController {
    func configureNavigationBar(on navigationBar: UINavigationBar, title: String, leftButton: UIBarButtonItem? = nil, rightButton: UIBarButtonItem? = nil, disableShadow: Bool = false) {
        
        let navigationItem = UINavigationItem(title: title)
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        navigationBar.setItems([navigationItem], animated: false)

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        
        if disableShadow {
            navigationBarAppearance.shadowColor = nil
        }
        
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
    }
}
