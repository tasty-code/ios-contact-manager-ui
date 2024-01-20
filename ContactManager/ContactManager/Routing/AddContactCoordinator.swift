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
    
    private let contactID: Int?
    
    private let navigationController: UINavigationController
    private let contactRepository: ContactRepository
    
    init(
        navigationController: UINavigationController,
        contactRepository: ContactRepository,
        contactID: Int?
    ) {
        self.navigationController = navigationController
        self.contactRepository = contactRepository
        self.contactID = contactID
    }
    
    func start() {
        let useCase = AddContactUseCase(
            repository: self.contactRepository,
            factory: ContactFactory()
        )
        let addContactViewController = AddContactViewController(
            contactId: self.contactID,
            useCase: useCase,
            coordinator: self
        )
        
        if let contactID {
            self.navigationController.pushViewController(addContactViewController, animated: true)
        } else {
            let destinationViewController = UINavigationController(rootViewController: addContactViewController)
            self.navigationController.present(destinationViewController, animated: true)
        }
    }
}

// MARK: - AddContactViewControllerDelegate Implementation

protocol AddContactViewControllerDelegate: AnyObject {
    func endAddContact()
    func cancelAddContact()
}

extension AddContactCoordinator: AddContactViewControllerDelegate {
    func endAddContact() {
        if self.contactID == nil {
            self.navigationController.dismiss(animated: true)
        } else {
            self.navigationController.popViewController(animated: true)
        }
        self.parentCoordinator?.didEndAddContact(self)
    }
    
    func cancelAddContact() {
        if self.contactID == nil {
            self.navigationController.dismiss(animated: true)
        } else {
            self.navigationController.popViewController(animated: true)
        }
    }
}
