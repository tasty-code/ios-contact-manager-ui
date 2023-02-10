//
//  SearchResultTableViewController.swift
//  ContactManagerUI
//
//  Created by DONGWOOK SEO on 2023/02/10.
//

import UIKit

final class SearchResultTableViewController: UITableViewController {
    var showSuggestedSearches: Bool = false {
        didSet {
            if oldValue != showSuggestedSearches {
//                tableView.reloadData()
            }
        }
    }
}
