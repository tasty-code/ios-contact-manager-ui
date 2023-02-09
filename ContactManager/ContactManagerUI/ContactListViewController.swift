//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let contactUIManager = ContactUIManager(validator: Validator())
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak private var contactListTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func tappedAddContactButton(_ sender: UIBarButtonItem) {
        guard let addContactVC = UIStoryboard(name: "AddContact", bundle: nil).instantiateViewController(withIdentifier:"AddContactViewController") as? AddContactViewController else { return }
        addContactVC.contactUIManager = contactUIManager
        addContactVC.contactListTableView = contactListTableView
        self.present(addContactVC, animated: true)
    }
}

// MARK: - Methods

extension ContactListViewController {

    private func setDelegate() {
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactUIManager.countContactLists()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = ContactTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactTableViewCell else { return UITableViewCell()}
        
        let contacts = contactUIManager.getContactsData()
        
        guard let cellData = contacts[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.name.text = cellData.name
        cell.age.text = String(cellData.age)
        cell.phoneNumber.text = cellData.phoneNum
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let selectedItem = self.contactUIManager.getContactsData()[indexPath.row]
            
            self.contactUIManager.deleteContactData(of: selectedItem)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            self.contactUIManager.setStoredContactsData()
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
