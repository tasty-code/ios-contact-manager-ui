//
//  WholeListTableViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import UIKit

class WholeListTableViewController: UITableViewController {

    private var contactBook: ContactBook = ContactBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        contactBook = ContactBook()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return contactBook.getSectionCount()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath)
        
        cell.textLabel?.text = contactBook.showContactList(indexPath).name + "(\(contactBook.showContactList(indexPath).age))"
        cell.detailTextLabel?.text = contactBook.showContactList(indexPath).digits
        
        return cell
    }
}
