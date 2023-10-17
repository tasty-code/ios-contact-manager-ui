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
        return contactManager.contactsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let contact = contactManager.showContact(index: indexPath.row)
        cell.textLabel?.text = "\(contact.name)(\(contact.age))"
        cell.detailTextLabel?.text = "\(contact.phoneNumber)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
                let _ = contactManager.addContact(contact)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ContactsViewController: ContactsTableViewUpdateDelegate {
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

