//
//  ContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/4/24.
//

import UIKit

final class ContactsViewController: UIViewController {

    private let contactsView: ContactsView
    private var dataSource: ContactsModel?
    
    init( dataSource: ContactsModel?) {
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
        contactsView.setSearchBarDelegate(delegate: self)
        contactsView.setDataSource(dataSource: self)
        contactsView.setDelegate(delegate: self)
    }
}

extension ContactsViewController {
    @objc func presentContactsAdditionModalView() {
        present(contactsAdditionModalViewController(), animated: true)
    }
    
    private func contactsAdditionModalViewController() -> ContactsAdditionModalViewController {
        let contactsAdditionModalViewController = ContactsAdditionModalViewController(delegate: dataSource)
        contactsAdditionModalViewController.setReloadData(reloadData: { [weak self] in
            guard let contactsView = self?.contactsView else {
                return
            }
            contactsView.reloadTableViewData()
        })
        return contactsAdditionModalViewController
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource?.filter(by: searchText)
        contactsView.reloadTableViewData()
    }
}

extension ContactsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.contacts().count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ContactsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.className, for: indexPath) as? ContactsTableViewCell,
                let contact: Contact = dataSource?.contacts()[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setContactLabelText(contact: contact)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let contact = dataSource?.contacts()[indexPath.row] else {
                return
            }
            dataSource?.delete(contact.hashValue)
            contactsView.reloadTableViewData()
        }
    }
}

extension ContactsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactsAdditionModalViewController = contactsAdditionModalViewController()
        contactsAdditionModalViewController.setPreviousContact(dataSource?.contacts()[indexPath.row])
        present(contactsAdditionModalViewController, animated: true)
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
