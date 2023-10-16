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
        configureNavigationBar()
        self.tableView.dataSource = self
        observeUpdatedContacts()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "연락처"
        self.navigationItem.rightBarButtonItem = buildAddButton()
    }
    
    private func buildAddButton() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(systemItem: .add)
        addButton.target = self
        addButton.action = #selector(tapAddButton(_:))
        return addButton
    }
    
    @objc private func tapAddButton(_ sender: UIButton) {
        if let viewController = storyboard?.instantiateViewController(identifier: "EditContactViewController", creator: { coder in
            return EditContactViewController(coder: coder, contactValidityChecker: ContactValidityChecker(), contactManager: self.contactManager)
        }) {
            present(UINavigationController(rootViewController: viewController), animated: true)
        }
    }
    
    @objc private func reloadContacts(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    
    private func observeUpdatedContacts() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadContacts(_:)), name: Notification.didUpdateContact, object: nil)
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "ContactCell"
        let contact = contactManager.contacts[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? ContactCell else {
            let cell = ContactCell(style: .subtitle, reuseIdentifier: id)
            cell.configureCell(contact)
            return cell
        }
        cell.configureCell(contact)
        return cell
    }
}

