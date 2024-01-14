//
//  ViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 1/3/24.
//

import UIKit

final class ContactListViewController: UIViewController, UpdateNewContact {
    private let contactFileManager = ContactFileManager()
    @IBOutlet weak var tableView: UITableView!
    
    //    required init?(coder: NSCoder) {
    //        self.contactFileManager = ContactFileManager()
    //        super.init(coder: coder)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        contactFileManager.loadJson()
        configureUI()
    }
    
    func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, 
                                                            target: self,
                                                            action: #selector(showNewContactView))
    }
    
    @objc func showNewContactView() {
        guard let nextVC = storyboard?.instantiateViewController(identifier: "NewContactViewController") as? NewContactViewController else {
            return
        }
        nextVC.delegate = self
        present(nextVC, animated: true)
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
