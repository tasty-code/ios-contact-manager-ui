//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import UIKit

final class ContactListViewController: UIViewController {
    private let contactManager = ContactManager()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ContactListCell")
        let contact = contactManager.contacts[indexPath.row]
        
        cell.textLabel?.text = "\(contact.name)(\(contact.age))"
        cell.detailTextLabel?.text = "\(contact.phoneNumber)"
        return cell
    }
}
