//
//  ContactTableViewController.swift
//  ContactManager
//
//  Created by Janine on 2023/10/06.
//

import UIKit

final class ContactTableViewController: UITableViewController {
    private let contactManager = ContactManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        loadJsonData()
        self.searchBar.delegate = self
    }
    
    private func setupAttributes() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let contactCreationViewController = ContactModifierViewController(delegate: self)
        
        present(contactCreationViewController, animated: true)
    }
    
    private func loadJsonData() {
        guard let jsonURL = Bundle.main.url(forResource: "mockData", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let root = try JSONDecoder().decode(Root.self, from: data)
            contactManager.setContactsList(root.data)
        } catch {
            print(error)
        }
    }
}

// MARK: - TableView Data Source

extension ContactTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = isFiltering ? contactManager.filteredList.count: contactManager.countOfContactList
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactTableCell", for: indexPath) as! ContactTableViewCell
        
        let content = isFiltering ? contactManager.filteredList[indexPath.row] : contactManager.contactsList[indexPath.row]
        
        cell.configure(content: content)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let uuid = isFiltering ? contactManager.filteredList[indexPath.row].uuid : contactManager.contactsList[indexPath.row].uuid
    
        contactManager.delete(uuid)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactModifierVC = ContactModifierViewController(delegate: self, current: contactManager.contactsList[indexPath.row])
        
        present(contactModifierVC, animated: true)
    }
}

// MARK: - Search Delegate

extension ContactTableViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isFiltering = true
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = self.searchBar.text else { return }
        contactManager.filterContactsList(by: text)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = self.searchBar.text else { return }
        contactManager.filterContactsList(by: text)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = nil
        searchBar.showsCancelButton = false
        contactManager.filterContactsList(by: "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
}

//MARK: - Contact Modifier Delegate

extension ContactTableViewController: ContactUpdatable {
    func addContact(_ contact: ContactInfo) {
        contactManager.add(contact)
        tableView.insertRows(at: [IndexPath(row: contactManager.countOfContactList - 1, section: 0)], with: .automatic)
    }
    
    func updateContact(_ contact: ContactInfo, of uuid: UUID) {
        contactManager.update(contact, of: uuid)
        tableView.reloadData()
    }
}
