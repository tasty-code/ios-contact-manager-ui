//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import UIKit

final class ContactListViewController: UIViewController {
    private let contactManager = ContactManager()
    private var filteredContacts = [Contact]()
    private var isActive: Bool {
        navigationItem.searchController?.isActive ?? false
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
        observeUpdatedContacts()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "연락처"
        self.navigationItem.rightBarButtonItem = buildAddButton()
        self.navigationItem.searchController = makeSearchBar()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func buildAddButton() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(systemItem: .add)
        addButton.target = self
        addButton.action = #selector(tapAddButton(_:))
        return addButton
    }
    
    @objc private func tapAddButton(_ sender: UIButton) {
        if let viewController = storyboard?.instantiateViewController(identifier: "EditContactViewController", creator: { coder in
            return EditContactViewController(coder: coder, contactValidityChecker: ContactValidityChecker(), contactManager: self.contactManager)
        }) {
            present(UINavigationController(rootViewController: viewController), animated: true)
        }
    }
    
    @objc private func reloadContacts(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    
    private func observeUpdatedContacts() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadContacts(_:)), name: Notification.didUpdateContact, object: nil)
    }
    
    private func makeSearchBar() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        return searchController
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isActive ? filteredContacts.count : contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "ContactCell"
        let contact = isActive ? filteredContacts[indexPath.row] : contactManager.contacts[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? ContactCell else {
            let cell = ContactCell(style: .subtitle, reuseIdentifier: id)
            cell.configureCell(contact)
            return cell
        }
        cell.configureCell(contact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try contactManager.delete(contactManager.contacts[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                return
            }
        }
    }
}

extension ContactListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            filteredContacts = contactManager.contacts.filter { $0.name.localizedCaseInsensitiveContains(text) }
            tableView.reloadData()
        }
    }
}
