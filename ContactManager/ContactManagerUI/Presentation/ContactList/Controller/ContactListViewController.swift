//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

protocol UpdateDataProtocol {
    
    func delevaryupdatedData(_ data: UserInputModel) throws
}

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
    
    @IBAction private func tappedAddContactButton(_ sender: UIBarButtonItem) {
        guard let addContactVC = UIStoryboard(name: "AddContact", bundle: nil).instantiateViewController(withIdentifier:"AddContactViewController") as? AddContactViewController else { return }
        addContactVC.delegate = self
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
        searchController.automaticallyShowsCancelButton = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

//MARK: - UdateDataProtocol

extension ContactListViewController: UpdateDataProtocol {
    
    func delevaryupdatedData(_ data: UserInputModel) throws {
        try contactUIManager.runProgram(menu: .add, userInputModel: data)
        contactUIManager.setStoredContactsData()
        contactListTableView?.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cellDataInRow = contactUIManager.getSortedContacts()[indexPath.row]
        if isSearching { cellDataInRow = searchedContacts[indexPath.row] }
        
        let alert = UIAlertController(title: "\(cellDataInRow.name)님의\n연락처가 복사되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "닫기", style: .destructive)
        let action = UIAlertAction(title: "메시지 보내기", style: .default) { _ in
            let phoneNum = cellDataInRow.phoneNum
            if let url = URL(string: "sms://\(phoneNum)") {
                UIApplication.shared.open(url)
            }
        }
        alert.addAction(cancel)
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
        guard let cellDataInRow = contactUIManager.getSortedContacts()[safe: indexPath.row] else { return UITableViewCell() }
        
        if isSearching {
            let cellData = searchedContacts[indexPath.row]
            cell.setData(ContactTableViewModel(name: cellData.name, age: String(cellData.age), phoneNumber: cellData.phoneNum))
        } else {
            cell.setData(ContactTableViewModel(name: cellDataInRow.name, age: String(cellDataInRow.age), phoneNumber: cellDataInRow.phoneNum))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if isSearching { return nil }
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let selectedItem = self.contactUIManager.getSortedContacts()[indexPath.row]
            
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

//MARK: - UISearchResultUpdating, UISearchBarDelegate

extension ContactListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: "닫기", style: .done, target: self, action: #selector (closeButtonTappedAction))
        bar.items = [done]
        bar.sizeToFit()
        searchController.searchBar.inputAccessoryView = bar
        
        guard let text = searchController.searchBar.text else { return }
        searchedContacts = contactUIManager.getSortedContacts().filter { $0.name.contains(text) }
        contactListTableView.reloadData()
    }
    
    @objc
    func closeButtonTappedAction() {
        self.navigationItem.searchController?.searchBar.searchTextField.resignFirstResponder()
    }
}
