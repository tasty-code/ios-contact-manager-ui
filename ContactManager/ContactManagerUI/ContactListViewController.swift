//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: - Properties

    private let dummyContactList = Person.dummyData

    // MARK: - @IBOutlet Properties

    @IBOutlet weak private var contactListTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    // MARK: - Methods

    private func setDelegate() {
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
}

// MARK: - Extensions: UITableViewDelegate, UITableViewDataSource

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cellData = dummyContactList[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.textLabel?.text = cellData.name + "(\(cellData.age))"
        cell.detailTextLabel?.text = cellData.phoneNum
        return cell
    }
}
