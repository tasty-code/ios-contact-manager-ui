//
//  ContactListViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/01/30.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    private let dummyContactList = Person.dummyData

    @IBOutlet weak var contactListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
    }
    
    private func setDelegate() {
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyContactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ContactTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dummyContactList[indexPath.row].name + "(\(dummyContactList[indexPath.row].age))"
        cell.detailTextLabel?.text = dummyContactList[indexPath.row].phoneNum
        return cell
    }
}
