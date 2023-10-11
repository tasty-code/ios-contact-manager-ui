//
//  ContactCreationViewController.swift
//  ContactManager
//
//  Created by Wonji Ha on 2023/10/11.
//

import UIKit

class ContactCreationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = .systemBackground
        view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
