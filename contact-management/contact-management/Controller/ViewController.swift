//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    private var contactListStorage = ContactListStorage()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "연락처"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        UI_테스트(Storage: contactListStorage)
    }
}

extension ViewController: UITableViewDataSource {
    
    private func contact(forID id: Int) -> ContactList {
        return contactListStorage.showContact(who: id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListStorage.countContactList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let item = contact(forID: indexPath.row)
        
        cell.textLabel?.text = "\(item.name) (\(item.age))"
        cell.detailTextLabel?.text = item.phoneNumber
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

