
import UIKit

class MainCoordinator: Coorninator {
    
    
    var childCoordninators = [Coorninator]()
    var navigationController: UINavigationController
    
    let phoneBookViewController = Container.shared.resolve(PhoneBookViewController.self)
    let registerViewController = Container.shared.resolve(RegisterViewController.self)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        phoneBookViewController.coordinator = self
        navigationController.pushViewController(phoneBookViewController, animated: false)
    }
    
    func goToRegisterViewController() {
        registerViewController.coordinator = self
        registerViewController.modalPresentationStyle = .formSheet
        phoneBookViewController.present(registerViewController, animated: true)

    }
}
