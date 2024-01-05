//
//  ViewController.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    let contactStorage = ContactStorage()
    let cellIdentifier = "contactCell"

    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    private func configure() {
        self.contactTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactStorage.contacteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = contactStorage.contactStorage[indexPath.row].nameAndAge
        cell.detailTextLabel?.text = contactStorage.contactStorage[indexPath.row].phoneNumber
        
        return cell
    }
}
