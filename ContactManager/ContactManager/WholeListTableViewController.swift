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
        contactBook.setContactList([Person(name: "Howard", age: 34, digits: "010-1234-1234"), Person(name: "Mond", age: 12, digits: "010-1234-1234"), Person(name: "Thor", age: 7, digits: "010-1234-1234"), Person(name: "Dora", age: 99, digits: "010-1234-1234"), Person(name: "JaeHyuk", age: 88, digits: "010-1234-1234")])
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactBook.getRowCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath)
        
        cell.textLabel?.text = contactBook.showContactList(indexPath).name + "(\(contactBook.showContactList(indexPath).age))"
        cell.detailTextLabel?.text = contactBook.showContactList(indexPath).digits
        
        return cell
    }
}
