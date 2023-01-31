//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 이상윤 on 2023/01/31.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           contactsTableView.delegate = self
           contactsTableView.dataSource = self
       }
   }

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "ContactCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}


