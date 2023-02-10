//
//  ContactDataSource.swift
//  ContactManagerUI
//
//  Created by Mason Kim on 2023/02/03.
//

import UIKit

final class ContactDataSource: NSObject, UITableViewDataSource {

    var contacts: [Contact] = [] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.didUpdateContacts, object: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: ContactCell.self, for: indexPath)

        if let contact = contacts[safe: indexPath.row] {
            cell.configure(with: contact)
        }

        return cell
    }
}
