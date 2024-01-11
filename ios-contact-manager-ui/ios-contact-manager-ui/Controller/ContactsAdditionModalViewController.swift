//
//  ContactsAdditionModalViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/9/24.
//

import UIKit

final class ContactsAdditionModalViewController: UIViewController {
    var delegate: ContactsManageable?

    private let contactsAdditionModalView: ContactsAddtionModalView = ContactsAddtionModalView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contactsAdditionModalView
    }
    
    @objc func dismissContactsAdditionModalView() {
        makeCancelAlert(message: "정말로 취소하시겠습니까?", destructiveAction: { _ in self.dismiss(animated: true) })
    }
}
