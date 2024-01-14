//
//  SceneDelegate.swift
//  ContactManager
//
//  Created by Effie on 1/5/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        let repository = ContactRepositoryImpl(
            contactList: ContactList(),
            fileProvider: BundleResourceManager()
        )
        let coordinator = AppCoordinator(
            navigationController: navigationController,
            contactRepository: repository
        )
        coordinator.start()
        self.coordinator = coordinator
        
        window.makeKeyAndVisible()
        self.window = window
    }
}
