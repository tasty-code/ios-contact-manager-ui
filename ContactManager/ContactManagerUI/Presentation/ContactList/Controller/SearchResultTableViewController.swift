//
//  SearchResultTableViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/10.
//

import UIKit

final class SearchResultTableViewController: UITableViewController {
    
    var contactUIManager: ContactUIManager?
    var filteredContacts: [Person]?
    
    var showSuggestedSearches: Bool = false {
        didSet {
            if oldValue != showSuggestedSearches {
                
                
                
                //    var showSuggestedSearches: Bool = false {
                //        didSet {
                //            if oldValue != showSuggestedSearches {
                //                tableView.reloadData()
                //            }
                //        }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let filteredContacts else { return 0 }
        return filteredContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let filteredContacts else { return UITableViewCell() }
        let cell = tableView.dequeueCell(type: ContactTableViewCell.self, indexPath: indexPath)
        let contacts = filteredContacts
        
        guard let cellDataInRow = contacts[safe: indexPath.row] else { return UITableViewCell() }
        
        cell.name.text = cellDataInRow.name
        cell.age.text = String(cellDataInRow.age)
        cell.phoneNumber.text = cellDataInRow.phoneNum
        
        return cell
    }
    
}
