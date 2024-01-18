//
//  ContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/4/24.
//

import UIKit

final class ContactsViewController: UIViewController {

    private let contactsView: ContactsView
    private var dataSource: ContactsDelegate?
    
    init( dataSource: ContactsDelegate?) {
        contactsView = ContactsView()
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contactsView
        contactsView.searchBar.delegate = self
        contactsView.setDataSource(dataSource: self)
    }
}

extension ContactsViewController {
    @objc func presentContactsAdditionModalView() {
        let contactsAdditionModalViewController = ContactsAdditionModalViewController(delegate: dataSource)
        contactsAdditionModalViewController.setReloadData(reloadData: { [weak self] in
            guard let contactsView = self?.contactsView else {
                return
            }
            let tableView = contactsView.tableView
            tableView.reloadData()
        })
        present(contactsAdditionModalViewController, animated: true)
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource?.filter(by: searchText)
        let tableView = contactsView.tableView
        tableView.reloadData()
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.contacts().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.className, for: indexPath) as? ContactsTableViewCell
        
        guard let contact: Contact = dataSource?.contacts()[indexPath.row] else {
            return cell ?? UITableViewCell()
        }
        
        cell?.setContactLabelText(contact: contact)
//        var content = cell.defaultContentConfiguration()
//        
//        content.text = "\(contact.name)(\(contact.age))"
//        content.secondaryText = contact.phoneNumber
//        content.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
//        
//        cell.contentConfiguration = content
//        cell.accessoryType = .disclosureIndicator

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let contact = dataSource?.contacts()[indexPath.row] else {
                return
            }
            dataSource?.delete(contact)
            let tableView = contactsView.tableView
            tableView.reloadData()
        }
    }
}

extension ContactsViewController {
    private func setupContactsTableViewConstraints() {
        contactsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactsView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contactsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }
}
