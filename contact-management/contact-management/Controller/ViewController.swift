//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

class ViewController: UIViewController {

    private var contactListStorage: ContactListStorage
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        self.contactListStorage = ContactListStorage()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "연락처"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // test 코드
        contactListStorage.addContact(name: "noam", phoneNumber: "010-1111-1111", age: 28)
        contactListStorage.addContact(name: "hero", phoneNumber: "010-2222-2222", age: 18)
        contactListStorage.addContact(name: "billon", phoneNumber: "010-3333-3333", age: 17)
    }
    
    private func showContact(who id: Int) -> ContactList {
        var checkedContact: ContactList?
        do {
            checkedContact = try contactListStorage.showContact(who: id)
        } catch {
            checkedContact = nil
        }
        return checkedContact!
    }
    
}


// MARK: TableView
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListStorage.sizeContactList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        let item = showContact(who: indexPath.row)
        cell?.textLabel?.text = item.name
        cell?.detailTextLabel?.text = item.phoneNumber
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

