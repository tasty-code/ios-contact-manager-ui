//
//  AppCoordinator.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let contactRepository: ContactRepository
    
    init(
        navigationController: UINavigationController,
        contactRepository: ContactRepository
    ) {
        self.navigationController = navigationController
        self.contactRepository = contactRepository
    }
    
    func start() {
        let coordinator = ListContactCoordinator(
            navigationController: self.navigationController,
            contactRepository: self.contactRepository
        )
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}
