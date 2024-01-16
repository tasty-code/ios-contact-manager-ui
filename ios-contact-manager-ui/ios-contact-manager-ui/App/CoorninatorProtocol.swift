
import UIKit

protocol Coorninator {
    var childCoordninators: [Coorninator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func goToRegisterViewController()
}
