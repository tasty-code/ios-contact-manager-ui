//
//  ContactsViewController.swift
//  Contact-Manager-iOS
//
//  Created by nayeon  on 2024/01/05.
//

import UIKit

final class ContactsViewController: UIViewController {
    
    //MARK: - Property
    private let contactManager: ContactManager = ContactManagerMock()
    private let contactsView: ContactsView = ContactsView()
    
    
    //MARK: - Life Cycle
    override func loadView() {
        self.view = contactsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    
    //MARK: - Method
    private func configureTableView() {
        contactsView.contactsTableView.dataSource = self
        contactsView.contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactTableViewCell")
    }
    
}
    

//MARK: - Extension
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.showUpAllContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ContactTableViewCell")
        let contact = contactManager.showUpAllContacts()[indexPath.row]
        
        cell.textLabel?.text = "\(contact.name ?? "알수없는 사용자")(\(contact.age ?? "0"))"
        cell.detailTextLabel?.text = contact.contactNumber
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}
