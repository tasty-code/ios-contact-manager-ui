//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contactUIManager = ContactUIManager(validator: Validator())
    private var searchedContacts: [Person] = []
    private var isSearching: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak private var contactListTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setSearchController()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func tappedAddContactButton(_ sender: UIBarButtonItem) {
        guard let addContactVC = UIStoryboard(name: "AddContact", bundle: nil).instantiateViewController(withIdentifier:"AddContactViewController") as? AddContactViewController else { return }
        addContactVC.contactUIManager = contactUIManager
        addContactVC.contactListTableView = contactListTableView
        self.present(addContactVC, animated: true)
    }
}

// MARK: - Methods

extension ContactListViewController {
    
    private func setDelegate() {
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search User"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellDataInRow = contactUIManager.getContactsData()[safe: indexPath.row] else { return }
        let alert = UIAlertController(title: "\(cellDataInRow.name)님의\n연락처가 복사되었습니다.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
        UIPasteboard.general.string = cellDataInRow.phoneNum
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchedContacts.count : contactUIManager.countContactLists()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: ContactTableViewCell.self, indexPath: indexPath)
        guard let cellDataInRow = contactUIManager.getContactsData()[safe: indexPath.row] else { return UITableViewCell() }
        isSearching ? cell.setData(with: searchedContacts[indexPath.row]) : cell.setData(with: cellDataInRow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if isSearching { return nil }
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let selectedItem = self.contactUIManager.getContactsData()[indexPath.row]
            
            self.contactUIManager.deleteContactData(of: selectedItem)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            self.contactUIManager.setStoredContactsData()
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

//MARK: - UISearchResultUpdating

extension ContactListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchedContacts = contactUIManager.getContactsData().filter { $0.name.contains(text) }
        contactListTableView.reloadData()
    }
}
