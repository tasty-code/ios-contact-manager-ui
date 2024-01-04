//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    let contactList: [Contact] = [
        Contact(name: "Harry", age: 20, phoneNumber: "010-1234-5678"),
        Contact(name: "Hoi", age: 20, phoneNumber: "010-0000-0000"),
        Contact(name: "Dio", age: 20, phoneNumber: "010-1111-1111")
    ]
    
    @IBOutlet weak var contactTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        return cell
    }
}

