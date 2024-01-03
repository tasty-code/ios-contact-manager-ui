
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Container.shared.bind(service: PhoneBook.self) { _ in
            return PhoneBook()
        }
        
        Container.shared.bind(service: PhoneBookViewController.self) { resolver in
            let phoneBook = resolver.resolve(PhoneBook.self)
            let phoneBookViewController = PhoneBookViewController()
            phoneBookViewController.phoneBook = phoneBook
            return phoneBookViewController
        }
        
        let phoneBookViewController = Container.shared.resolve(PhoneBookViewController.self)
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = phoneBookViewController
    }
}
