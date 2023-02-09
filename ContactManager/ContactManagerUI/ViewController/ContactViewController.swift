//
//  ContactViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var contactTableView: UITableView!
    
    private let contactDataSource = ContactDataSource()
    private var contacts: [Contact] = [] {
        didSet {
            contactDataSource.contacts = contacts
            contactTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchContactData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddContactViewController {
            viewController.delegate = self
        }
    }
    
    // MARK: - Helpers
    private func setupTableView() {
        contactTableView.dataSource = contactDataSource
    }
    
    private func fetchContactData() {
        // 임시 연락처 데이터
        mockupContacts.forEach {
            ContactManager.shared.add(contact: $0)
        }
        contacts = ContactManager.shared.fetchContacts()
    }
}

extension ContactViewController: AddContactViewControllerDelegate {
    func addContactViewController(_ addContactViewController: AddContactViewController, didAddContact contact: Contact) {
        contacts.append(contact)
    }
}
