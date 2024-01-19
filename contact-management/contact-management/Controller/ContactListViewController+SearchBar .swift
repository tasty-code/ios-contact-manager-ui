//
//  ContactListViewController+SearchBar .swift
//  contact-management
//
//  Created by Roh on 1/19/24.
//

import UIKit

extension ContactListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if(searchController.isActive) {
            filteredDataSource = (contactListStorage?.getContactList().filter { list in
                list.name.contains(text)
            })!
        } else {
            filteredDataSource = (contactListStorage?.getContactList())!
        }
        tableView.reloadData()
    }
}
