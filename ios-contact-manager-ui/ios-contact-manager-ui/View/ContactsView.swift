//
//  ContactsView.swift
//  ios-contact-manager-ui
//
//  Created by Kim EenSung on 1/8/24.
//

import UIKit

final class ContactsView: UIView {
    private weak var dataSource: UITableViewDataSource? {
        didSet {
            self.tableView.dataSource = self.dataSource
        }
    }
    let tableView: UITableView
    private let navigationBar: ContactsNavigationBar
    
    override init(frame: CGRect) {
        self.tableView = UITableView()
        navigationBar = ContactsNavigationBar()
        super.init(frame: frame)
        setupView()
        setupTableView()
        addSubview(navigationBar)
        addSubview(tableView)
        setupNavigationBarConstraints()
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactsView {
    public func setDataSource(dataSource: UITableViewDataSource?) {
        self.dataSource = dataSource
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
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ContactCell")
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
