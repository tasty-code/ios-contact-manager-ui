//
//  ViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 1/3/24.
//

import UIKit

final class ContactListViewController: UIViewController, UpdateNewContact {
    private let contactFileManager = ContactFileManager()
    var filteredDataSource: [Contact] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var isFiltering: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.dataSource = self
        tableView.delegate = self
        contactFileManager.loadJson()
    }
    
    private func configureUI() {
        setUpSearchBar()
        AddContactButtonTapped()
    }
    
    private func AddContactButtonTapped() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showNewContactView))
    }
    
    @objc private func showNewContactView() {
        var selectedContact: Contact?
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            selectedContact = isFiltering ? filteredDataSource[selectedIndexPath.row] : contactFileManager.contacts[selectedIndexPath.row]
        }
        
        guard let newContactViewController = storyboard?.instantiateViewController(identifier: "NewContactViewController", creator: { coder in
            NewContactViewController(coder: coder, contactFileManager: self.contactFileManager, delegate: self, selectedContact: selectedContact)
        }) as? NewContactViewController else {
            return
        }
        present(newContactViewController, animated: true)
    }
}

// MARK: - TableView Methods
extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredDataSource.count : contactFileManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = isFiltering ? filteredDataSource[indexPath.row] : contactFileManager.contacts[indexPath.row]
        cell.textLabel?.text = contact.nameAndAge
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !isFiltering {
            let delete = UIContextualAction(style: .destructive, title: "delete") { (_, _, success: @escaping (Bool) -> Void) in
                self.contactFileManager.removeContact(indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                success(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNewContactView()
    }
    
    func updateNewContact() {
        tableView.reloadData()
    }
}

// MARK: - Search Controller
extension ContactListViewController: UISearchResultsUpdating {
    private func setUpSearchBar() {
    let searchBarController = UISearchController(searchResultsController: nil)
    searchBarController.hidesNavigationBarDuringPresentation = false
    self.navigationItem.searchController = searchBarController
    searchBarController.searchResultsUpdater = self
    searchBarController.searchBar.delegate = self
}
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredDataSource = contactFileManager.contacts.filter { contact in
            return contact.nameAndAge.localizedStandardContains(text) || contact.phoneNumber.localizedStandardContains(text)
        }
        tableView.reloadData()
    }
}

extension ContactListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
