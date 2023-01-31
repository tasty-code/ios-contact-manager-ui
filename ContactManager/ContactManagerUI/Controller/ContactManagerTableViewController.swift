//
//  ContactManagerTableViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/01/31.
//

import UIKit

class ContactManagerTableViewController: UITableViewController {

    @IBOutlet private weak var contactManagerTableView: UITableView!
    private var contactDataSource = ContactDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self.contactDataSource
    }
}

class ContactDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
