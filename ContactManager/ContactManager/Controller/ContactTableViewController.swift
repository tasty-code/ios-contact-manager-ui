//
//  TableViewController.swift
//  ContactManager
//
//  Created by Janine on 2023/10/06.
//

import UIKit

class ContactTableViewController: UITableViewController {
    private let contactManager = ContactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = contactManager.getContactList().count
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let name = contactManager.getContactList()[indexPath.row].name ?? ""
        let age = contactManager.getContactList()[indexPath.row].age ?? 0
        let phoneNumber = contactManager.getContactList()[indexPath.row].phoneNum ?? ""
        
        cell.textLabel!.text = "\(name) (\(age))"
        cell.detailTextLabel!.text = phoneNumber
        
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
            contactManager.setContactList(list: root.data)
        } catch {
            print(error)
        }
    }
}
