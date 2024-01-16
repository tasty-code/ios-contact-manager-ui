//
//  ViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 1/3/24.
//

import UIKit

final class ContactListViewController: UIViewController, UpdateNewContact {
    private let contactFileManager = ContactFileManager()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        contactFileManager.loadJson()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showNewContactView))
    }
    
    @objc private func showNewContactView() {
        guard let newContactViewController = storyboard?.instantiateViewController(identifier: "NewContactViewController", creator: { coder in
            NewContactViewController(coder: coder, contactFileManager: self.contactFileManager)
        }) as? NewContactViewController else {
            return
        }
        newContactViewController.delegate = self
        present(newContactViewController, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactFileManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = contactFileManager.contacts[indexPath.row]
        cell.textLabel?.text = contact.nameAndAge
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (_, _, success: @escaping (Bool) -> Void) in
            self.contactFileManager.removeContact(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func updateNewContact() {
        tableView.reloadData()
    }
}
