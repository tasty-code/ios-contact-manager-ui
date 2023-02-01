//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/01/30.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var contactTableView: UITableView!
    
    private var contacts: [Contact] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        contacts = mockupContacts
    }

    // MARK: - Helpers
    private func setupTableView() {
        contactTableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contactTableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as? ContactCell,
              let contact = contacts[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: contact)
        
        return cell
    }
    
    
}


