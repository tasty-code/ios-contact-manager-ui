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
        self.tableView.dataSource = self
        
        for i in 0...100 {
            try! contactManager.add(Contact(name: "123", age: i, phoneNumber: "123-123-1234"))
        }
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
            print("no cell \(indexPath.row)")
            return cell
        }
        cell.configureCell(contact)
        print("yes cell \(indexPath.row)")
        return cell
    }
}


