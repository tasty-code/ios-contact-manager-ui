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
    
    @objc func dismissContactsAdditionModalView() {
        makeCancelAlert(message: "정말로 취소하시겠습니까?", destructiveAction: { _ in self.dismiss(animated: true) })
    }
}
