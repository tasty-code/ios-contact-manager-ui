//
//  ContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/4/24.
//

import UIKit

final class ContactListViewController: UIViewController {

    private let contactsTableView: ContactsTableView
    private var contactArray: Array<Contact>
    var delegate: ContactsViewer?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        contactsTableView = ContactsTableView()
        delegate = ContactListModel()
        contactArray = []
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactArray = delegate?.sortedContacts() ?? []
        view = contactsTableView
        contactsTableView.tableView.dataSource = self
    }
}

extension ContactListViewController {
    @objc func presentContactsAdditionModalView() {
        let contactsAdditionModalViewController = ContactsAdditionModalViewController()
        contactsAdditionModalViewController.delegate = delegate as? any ContactsRepository
        present(contactsAdditionModalViewController, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact: Contact = contactArray[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = "\(contact.name)(\(contact.age))"
        content.secondaryText = contact.phoneNumber
        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

extension ContactListViewController {
    private func setupContactsTableViewConstraints() {
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contactsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }
}
