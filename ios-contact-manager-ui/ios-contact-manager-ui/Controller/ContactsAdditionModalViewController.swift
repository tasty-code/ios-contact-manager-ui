//
//  ContactsAdditionModalViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

class ContactsAdditionModalViewController: UIViewController {

    private let contactsModificationModalView: ContactsModificationModalView = ContactsModificationModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contactsModificationModalView
    }
}
