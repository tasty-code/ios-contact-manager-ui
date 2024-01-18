
import UIKit

protocol RegisterUserInfoDelegate: AnyObject {
    func goToRegisterViewController()
}

final class PhoneBookCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    let phoneBook = PhoneBook()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let phoneBookViewController = PhoneBookViewController()
        phoneBookViewController.phoneBook = phoneBook
        phoneBookViewController.coordinator = self
        navigationController.pushViewController(phoneBookViewController, animated: true)
    }
}

extension PhoneBookCoordinator: RegisterUserInfoDelegate {
    func goToRegisterViewController() {
        let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
        let registerViewController = storyboard.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        registerViewController.phoneBook = phoneBook
        registerViewController.coordinator = self
        
        registerViewController.modalPresentationStyle = .formSheet
        navigationController.present(registerViewController, animated: true)
    }
}
