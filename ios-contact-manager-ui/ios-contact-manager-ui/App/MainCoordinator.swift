
import UIKit

protocol Coorninator {
    var childCoordninators: [Coorninator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func goToRegisterViewController()
}

final class MainCoordinator: Coorninator {
        
    var childCoordninators = [Coorninator]()
    var navigationController: UINavigationController
    private let phoneBook = PhoneBook()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let phoneBookViewController = PhoneBookViewController()
        phoneBookViewController.coordinator = self
        phoneBookViewController.phoneBook = phoneBook

        navigationController.pushViewController(phoneBookViewController, animated: false)
    }
    
    func goToRegisterViewController() {
        let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
        let registerViewController = storyboard.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        registerViewController.coordinator = self
        registerViewController.phoneBook = phoneBook

        registerViewController.modalPresentationStyle = .formSheet
        navigationController.present(registerViewController, animated: true)
    }
}
