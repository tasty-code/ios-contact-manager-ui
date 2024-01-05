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
    
    private func showContact(who id: Int) -> ContactList {
        var checkedContact: ContactList?
        do {
            checkedContact = try contactListStorage.showContact(who: id)
        } catch {
            checkedContact = nil
        }
        return checkedContact!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListStorage.sizeContactList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let item = showContact(who: indexPath.row)
        
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

