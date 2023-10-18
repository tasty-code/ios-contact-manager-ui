//
//  FilteredContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 10/18/23.
//

import UIKit

class FilteredContactListViewController: UITableViewController {
    var filteredContacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            let cell = ContactCell(style: .default, reuseIdentifier: "ContactCell")
            cell.configureCell(filteredContacts[indexPath.row])
            return cell
        }
        
        cell.configureCell(filteredContacts[indexPath.row])
        return cell
    }
}
