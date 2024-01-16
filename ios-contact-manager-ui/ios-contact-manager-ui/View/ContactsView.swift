//
//  ContactsView.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/8/24.
//

import UIKit

final class ContactsView: UIView {

    let tableView: UITableView
    let searchBar: UISearchBar
    private let navigationBar: ContactsNavigationBar
    
    override init(frame: CGRect) {
        self.tableView = UITableView()
        navigationBar = ContactsNavigationBar()
        searchBar = UISearchBar()
        super.init(frame: frame)
        setupView()
        setupTableView()
        addSubview(navigationBar)
        addSubview(searchBar)
        addSubview(tableView)
        setupNavigationBarConstraints()
        setupSearchBarConstraints()
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactsView {
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupNavigationBarConstraints() {
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
