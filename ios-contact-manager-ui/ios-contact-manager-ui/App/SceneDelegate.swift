
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordniator: MainCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setDependence()
        
        let navigationController = UINavigationController()
        mainCoordniator = MainCoordinator(navigationController: navigationController)
        
        mainCoordniator?.start()
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        window?.backgroundColor = .white
    }
}


extension SceneDelegate {
    func setDependence() {
        Container.shared.bind(service: PhoneBook.self) { _ in
            return PhoneBook()
        }
        
        Container.shared.bind(service: PhoneBookViewController.self) { resolver in
            let phoneBook = resolver.resolve(PhoneBook.self)
            let phoneBookViewController = PhoneBookViewController()
            phoneBookViewController.phoneBook = phoneBook
            return phoneBookViewController
        }
        
        Container.shared.bind(service: RegisterViewController.self) { resolver in
            let phoneBook = resolver.resolve(PhoneBook.self)
            let storyboard = UIStoryboard(name: "RegisterViewController", bundle: nil)
            let registerViewController = storyboard.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
            registerViewController.phoneBook = phoneBook
            return registerViewController
        }
    }
}
