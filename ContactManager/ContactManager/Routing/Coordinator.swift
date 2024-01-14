//
//  Coordinator.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
}
