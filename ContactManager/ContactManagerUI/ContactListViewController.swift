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
        return contactUIManager.showListProgram().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let contacts = contactUIManager.showListProgram()
        
        guard let cellData = contacts[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = cellData.name + "(\(cellData.age))"
        cell.detailTextLabel?.text = cellData.phoneNum
        return cell
    }
    
}
