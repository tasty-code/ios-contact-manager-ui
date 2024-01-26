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
    private var filteredContacts: [Contact] = []
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = contactsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        contactManager.makeMockContactListData()
        configureNavigationBar()
        configureSearchBar()
    }
    
    
    //MARK: - Method
    private func configureNavigationBar() {
        title = "연락처"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "연락처 검색"
        searchController.searchBar.showsCancelButton = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        contactsView.contactsTableView.dataSource = self
        contactsView.contactsTableView.delegate = self
        contactsView.contactsTableView.register(ContactCustomTableViewCell.self, forCellReuseIdentifier: ContactCustomTableViewCell.reuseIdentifier)
    }
    
    @objc private func plusButtonTapped() {
        let detailContactViewController = DetailContctViewController()
        let detailContactNavigationViewController = UINavigationController(rootViewController: detailContactViewController)
        
        detailContactViewController.delegate = self
        detailContactViewController.title = "새 연락처"
        detailContactViewController.isPresentedModally.toggle()
        
        present(detailContactNavigationViewController, animated: true, completion: nil)
    }
}
    

//MARK: - Extension
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredContacts.count : contactManager.fetchAllContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: ContactCustomTableViewCell.reuseIdentifier, for: indexPath) as? ContactCustomTableViewCell else {
            fatalError("cell is not an instance of TableViewCell")
        }

        reusableCell.contact = isFiltering ? filteredContacts[indexPath.row] : contactManager.fetchAllContacts()[indexPath.row]

        return reusableCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let id = contactManager.fetchAllContacts()[indexPath.row].id
            contactManager.deleteContact(contactId: id)
            contactsView.contactsTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}
    
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailContactViewController: DetailContctViewController = DetailContctViewController()
        
        detailContactViewController.delegate = self
        detailContactViewController.title = "기존 연락처 수정"
        detailContactViewController.contact = contactManager.fetchAllContacts()[indexPath.row]
        
        navigationController?.pushViewController(detailContactViewController, animated: true)
    }
}

extension ContactsViewController: ContactDelegate {
    func addNewContact(newContact: Contact) {
        contactManager.addNewContact(contact: newContact)
        contactsView.contactsTableView.reloadData()
    }
    
    func updateContact(contactId id: Int, with selectedContact: Contact) {
        contactManager.updatedContact(contactId: id, with: selectedContact)
        contactsView.contactsTableView.reloadData()
    }
}

extension ContactsViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredContacts = contactManager.fetchAllContacts().filter { contact in
            return contact.name.lowercased().contains(searchText.lowercased())
        }

        contactsView.contactsTableView.reloadData()
    }

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
}
