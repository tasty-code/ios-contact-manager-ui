//
//  ContactTableViewController.swift
//  ContactManager
//
//  Created by Janine on 2023/10/06.
//

import UIKit

final class ContactTableViewController: UITableViewController {
    private let contactManager = ContactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttributes()
        loadJsonData()
    }
    
    private func setupAttributes() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let contactCreationViewController = ContactCreationViewController()
        contactCreationViewController.delegate = self
        
        present(contactCreationViewController, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = contactManager.countOfContactList
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactTableCell", for: indexPath) as! ContactTableViewCell
        
        let content = contactManager.contactsList[indexPath.row]
        cell.configure(content: content)
        return cell
    }
}

extension ContactTableViewController {
    func loadJsonData() {
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

extension ContactTableViewController: ContactUpdatable {
    func addContact(_ contact: ContactInfo) {
        contactManager.add(contact)
        tableView.insertRows(at: [IndexPath(row: contactManager.countOfContactList - 1, section: 0)], with: .automatic)
    }
}
