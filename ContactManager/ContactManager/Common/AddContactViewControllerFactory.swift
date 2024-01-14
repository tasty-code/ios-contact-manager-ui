//
//  AddContactViewControllerFactory.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

//enum AddContactViewControllerFactory {
//    static func make() -> UIViewController {
//        let repo = makeRepository()
//        let useCase = AddContactUseCase(repository: repo)
//        let viewController = AddContactViewController(
//            useCase: useCase,
//            coordinator: <#T##AddContactViewControllerDelegate#>
//        )
//        return UINavigationController(rootViewController: viewController)
//    }
//    
//    private static func makeRepository() -> ContactRepository {
//        let contactList = makeContactList()
//        let fileProvider = makeFileProvider()
//        return ContactRepositoryImpl(contactList: contactList, fileProvider: fileProvider)
//    }
//    
//    private static func makeFileProvider() -> FileProvidable {
//        let targetBundle = Bundle.main
//        return BundleResourceManager(target: targetBundle)
//    }
//    
//    private static func makeContactList() -> ContactList {
//        return ContactList()
//    }
//}
