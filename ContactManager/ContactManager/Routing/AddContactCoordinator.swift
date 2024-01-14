//
//  AddContactCoordinator.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class AddContactCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: AddContactCoordinatorDelegate?
    
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
        let useCase = AddContactUseCase(repository: self.contactRepository)
        let addContactViewController = AddContactViewController(
            useCase: useCase,
            coordinator: self
        )
        let destinationViewController = UINavigationController(rootViewController: addContactViewController)
        self.navigationController.present(destinationViewController, animated: true)
    }
}

// MARK: - AddContactViewControllerDelegate Implementation

protocol AddContactViewControllerDelegate: AnyObject {
    func endAddContact()
}

extension AddContactCoordinator: AddContactViewControllerDelegate {
    func endAddContact() {
        self.navigationController.dismiss(animated: true)
        self.parentCoordinator?.didEndAddContact(self)
    }
}
