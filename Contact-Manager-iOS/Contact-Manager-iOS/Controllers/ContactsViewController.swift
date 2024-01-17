//
//  ContactsViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//

import UIKit

final class ContactsViewController: UIViewController {
    
    //MARK: - Property
    private let contactManager: ContactManager = ContactManager()
    private let contactsView: ContactsView = ContactsView()
    
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = contactsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        contactManager.makeMockContactListData()
        configureNavigationBar()
    }
    
    
    //MARK: - Method
    private func configureTableView() {
        contactsView.contactsTableView.dataSource = self
        contactsView.contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.reuseIdentifier)
    }
    
    private func configureNavigationBar() {
        title = "연락처"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addContactTapped() {
        let addContactViewController = AddContactViewController(contactManager: contactManager)
        let navigationController = UINavigationController(rootViewController: addContactViewController)
        
        addContactViewController.delegate = self
        addContactViewController.title = "새 연락처"
        
        present(navigationController, animated: true, completion: nil)
    }
}
    

//MARK: - Extension
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.fetchAllContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as? ContactTableViewCell else {
            fatalError("cell is not an instance of TableViewCell")
        }

        let contact = contactManager.fetchAllContacts()[indexPath.row]
        cell.configure(with: contact)

        return cell
    }
    
}

extension ContactsViewController: ContactDelegate {
    func addNewContact(newContact: Contact) {
        contactManager.addNewContact(contact: newContact)
        contactsView.contactsTableView.reloadData()
    }
    
    func updatedContact(contactId id: Int, with selectedContact: Contact) {
        
    }
}
