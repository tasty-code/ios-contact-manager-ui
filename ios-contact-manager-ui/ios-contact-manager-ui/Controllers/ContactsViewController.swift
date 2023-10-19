//
//  ContactsViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import UIKit

final class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let contactManager = ContactManager()
    private let cellIdentifier = "ContactCell"
    private let newContactVCIdentifier = "NewContactViewController"
    private var isSearching = false
    private var searchingName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDummyData()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.searchBar.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        guard let newContactVC = storyboard?.instantiateViewController(identifier: newContactVCIdentifier) as? NewContactViewController else { return }
        newContactVC.configureData(self.contactManager, delegate: self)
        let navigationVC = UINavigationController(rootViewController: newContactVC)
        present(navigationVC, animated: true)
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? contactManager.fetchContactsContains(with: searchingName).count : contactManager.contactsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? ContactCell else { return UITableViewCell() }
        var contact: Contact
        
        if isSearching {
            let contacts = contactManager.fetchContactsContains(with: searchingName)
            contact = contacts[indexPath.row]
        } else {
            contact = contactManager.showContact(index: indexPath.row)
        }
        cell.configureCell(with: contact)
        
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ContactCell,
              let contact = cell.contact else { return }
        guard let newContactVC = storyboard?.instantiateViewController(identifier: newContactVCIdentifier) as? NewContactViewController else { return }
        newContactVC.configureData(self.contactManager, delegate: self, contact: contact)
        let navigationVC = UINavigationController(rootViewController: newContactVC)
        present(navigationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let cell = tableView.cellForRow(at: indexPath) as? ContactCell,
                    let contact = cell.contact else { return }
            contactManager.deleteContact(by: contact.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ContactsViewController {
    private func setDummyData() {
        guard let path = Bundle.main.path(forResource: "Contacts", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        let decoder = JSONDecoder()
        do {
            let contacts = try decoder.decode([Contact].self, from: jsonData)
            for contact in contacts {
                let _ = contactManager.add(contact)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ContactsViewController: ContactsTableViewUpdateDelegate {
    func didContactsChanged(_ contactId: ObjectIdentifier) {
        self.contactsTableView.reloadData()
    }
    
    func didContactsAdded(_ contactId: ObjectIdentifier) {
        guard let index = contactManager.fetchIndexOfContact(with: contactId) else { return }
        let indexPath = IndexPath(row: index, section: 0)
        self.contactsTableView.insertRows(at: [indexPath], with: .none)
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.isSearching = false
        } else {
            self.isSearching = true
            self.searchingName = searchText
        }
        self.contactsTableView.reloadData()
    }
}

