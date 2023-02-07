//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: - Properties

//    private let dummyContactList = Person.dummyData
    private let contactUIManager = ContactUIManager(validator: Validator())
    private let dataManager = DataManager.shared

    // MARK: - @IBOutlet Properties

    @IBOutlet weak private var contactListTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddContactView"{
            let addContactView = segue.destination as! AddContactViewController
            addContactView.contactUIManager = self.contactUIManager
        }
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
