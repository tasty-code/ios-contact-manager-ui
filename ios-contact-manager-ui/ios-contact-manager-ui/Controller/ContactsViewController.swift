//
//  ContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/4/24.
//

import UIKit

final class ContactsViewController: UIViewController {

    private let contactsTableView: ContactsTableView
    private var contacts: Array<Contact>
    var delegate: ContactsApproachable?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        contactsTableView = ContactsTableView()
        contacts = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = delegate?.sorted() ?? []
        view = contactsTableView
        contactsTableView.tableView.dataSource = self
    }
}

extension ContactsViewController {
    @objc func presentContactsAdditionModalView() {
        let contactsAdditionModalViewController = ContactsAdditionModalViewController()
        contactsAdditionModalViewController.delegate = delegate as? any ContactsManageable
        contactsAdditionModalViewController.reloadData = {
            self.contacts = self.delegate?.sorted() ?? []
            self.contactsTableView.tableView.reloadData()
        }
        present(contactsAdditionModalViewController, animated: true)
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact: Contact = contacts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(contact.name)(\(contact.age))"
        content.secondaryText = contact.phoneNumber
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

extension ContactsViewController {
    private func setupContactsTableViewConstraints() {
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contactsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }
}
