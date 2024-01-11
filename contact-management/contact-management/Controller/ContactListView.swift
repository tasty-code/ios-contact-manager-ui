//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

final class ContactListView: UIViewController {
    private var contactListStorage: ContactListStorage?
    @IBOutlet weak var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "연락처"
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ContactListView: UITableViewDataSource {
    private func getContact(forID id: Int) -> ContactList? {
        guard let result = self.contactListStorage else {
            return nil
        }
        return result.getContact(id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListStorage!.countContactList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        guard let item = getContact(forID: indexPath.row) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "\(item.name) (\(item.age))"
        cell.detailTextLabel?.text = item.phoneNumber
        return cell
    }
}

extension ContactListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

