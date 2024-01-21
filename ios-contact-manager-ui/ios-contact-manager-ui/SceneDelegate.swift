
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactListViewController = storyboard.instantiateViewController(identifier: "ContactListViewController") as! ContactListViewController
        
        let contactManager = ContactManager()
        
        contactListViewController.model = contactManager
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = contactListViewController
        window?.makeKeyAndVisible()
    }
}
