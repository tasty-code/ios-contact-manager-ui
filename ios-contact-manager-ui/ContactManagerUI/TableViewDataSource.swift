//
//  TableViewDataSource.swift
//  ContactManagerUI
//
//  Created by sei_dev on 2/1/23.
//

import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "contactCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }


}
