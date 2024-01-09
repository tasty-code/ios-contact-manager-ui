//
//  ContactsViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//

import UIKit

final class ContactsViewController: UIViewController {
    
    //MARK: - Property
    private let contactManager: ContactManager = ContactManager()
    private let contactsView: ContactsView = ContactsView()
    
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = contactsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        contactManager.makeMockContactListData()
    }
    
    
    //MARK: - Method
    private func configureTableView() {
        contactsView.contactsTableView.dataSource = self
        contactsView.contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.reuseIdentifier)
    }
    
}
    

//MARK: - Extension
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.fetchAllContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.reuseIdentifier, for: indexPath) as? ContactTableViewCell else {
            fatalError("cell is not an instance of TableViewCell")
        }

        let contact = contactManager.fetchAllContacts()[indexPath.row]
        cell.configure(with: contact)

        return cell
    }
    
}
