//
//  TableViewController.swift
//  ContactManager
//
//  Created by Janine on 2023/10/06.
//

import UIKit

class ContactTableViewController: UITableViewController {

    private let contactManager = ContactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
}

extension ContactTableViewController {
    func loadJsonData() {
        guard let jsonURL = Bundle(for: type(of: self)).path(forResource: "mockData", ofType: "json") else {
            return
        }
        
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL), encoding: String.Encoding.utf8) else {
            return
        }
        
        do {
            let root = try JSONDecoder().decode(Root.self, from: Data(jsonString.utf8))
            contactManager.setContactList(list: root.data)
        } catch {
            print("error")
        }
    }
}
