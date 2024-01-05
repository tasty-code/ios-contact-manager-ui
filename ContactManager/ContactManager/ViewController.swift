//
//  ViewController.swift
//  ContactManager
//
//  Created by 유니 & L on 1/3/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let contactFileManager = ContactFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        contactFileManager.loadJson()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactFileManager.contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = contactFileManager.contact[indexPath.row]
        cell.textLabel?.text = contact.nameAndAge
        cell.detailTextLabel?.text = contact.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
