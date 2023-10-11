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
        loadJsonData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = contactManager.countOfContactList
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        guard let name = contactManager.contactsList[indexPath.row].name, let age = contactManager.contactsList[indexPath.row].age,
              let phoneNumber = contactManager.contactsList[indexPath.row].phoneNum else {
            return cell
        }

        content.text = "\(name) (\(age))"
        content.secondaryText = phoneNumber
        cell.contentConfiguration = content

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
            contactManager.setContactList(root.data)
        } catch {
            print(error)
        }
    }
}
