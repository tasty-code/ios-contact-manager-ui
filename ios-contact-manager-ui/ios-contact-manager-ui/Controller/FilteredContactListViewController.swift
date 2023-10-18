//
//  FilteredContactListViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 10/18/23.
//

import UIKit

class FilteredContactListViewController: UITableViewController {
    private(set) var filteredContacts = [Contact]()
    private weak var contactManager: ContactManager?
    
    init?(coder: NSCoder, contactManager: ContactManager) {
        self.contactManager = contactManager
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: UITableViewCell.contactCell, bundle: nil), forCellReuseIdentifier: UITableViewCell.contactCell)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.contactCell, for: indexPath) as? ContactCell else {
            let cell = ContactCell(style: .default, reuseIdentifier: UITableViewCell.contactCell)
            cell.configureCell(filteredContacts[indexPath.row])
            return cell
        }
        
        cell.configureCell(filteredContacts[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try contactManager?.delete(filteredContacts[indexPath.row])
                filteredContacts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                NotificationCenter.default.post(name: Notification.didUpdateContact, object: nil)
            } catch {
                return
            }
        }
    }
    
    func setFilteredContacts(_ contacts: [Contact]) {
        filteredContacts = contacts
    }
}
