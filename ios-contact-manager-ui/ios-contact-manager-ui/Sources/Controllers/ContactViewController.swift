//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/2/24.
//

import UIKit

final class ContactViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactDetailCell.self, forCellReuseIdentifier: ContactDetailCell.identifier)
        return tableView
    }()
    
    private lazy var plusButton: UIBarButtonItem = {
        let customBtton = UIButton(type: .system)
        customBtton.setImage(UIImage(systemName: "plus"), for: .normal)
        customBtton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        let buttonSize = CGSize(width: 15, height: 15)
        customBtton.frame = CGRect(origin: .zero, size: buttonSize)
        
        let button = UIBarButtonItem(customView: customBtton)
        
        return button
    }()
    
    private lazy var search: UISearchController = {
        let search = UISearchController()
        navigationItem.searchController = search
        navigationItem.searchController?.searchBar.delegate = self
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.addSubview(search.searchBar)
        search.searchBar.setShowsCancelButton(false, animated: false)
        return search
    }()
    
    private let contactManager = ContactManager()
    
    private var filteredContacts: [Contact] {
        return contactManager.contacts.filter { $0.name.contains(search.searchBar.text ?? "") }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground()
        layout()
        parse()
        setupNaviBar()
    }
    
    private func viewBackground() {
        view.backgroundColor = .white
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setupNaviBar() {
        title = "연락처"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func parse() {
        do {
            try contactManager.parse()
        } catch {
            let alert = showErrorAlert(title: nil, error.localizedDescription, actions: [UIAlertAction(title: "취소", style: .default)])
            present(alert, animated: true)
        }
    }
    @objc private func plusButtonTapped() {
        let detailVC = ContactDetailViewController()
        detailVC.delegate = self
        present(UINavigationController(rootViewController: detailVC), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ContactViewController: UITableViewDataSource {
    private func isNotEmpty(_ name: String) -> Bool {
        return name.isEmpty == false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let name = search.searchBar.text, isNotEmpty(name) {
            return filteredContacts.count
        } else {
            return contactManager.contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailCell.identifier , for: indexPath) as? ContactDetailCell else { return UITableViewCell() }
        
        let item = contactManager.contacts[indexPath.row]
        cell.contact = item
        
        if let name = search.searchBar.text, isNotEmpty(name) {
            cell.contact = filteredContacts[indexPath.row]
        } else {
            cell.contact = contactManager.contacts[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            contactManager.delete(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

// MARK: - UITableViewDelegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = ContactDetailViewController()
        detailVC.contact = contactManager.contacts[indexPath.row]
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - ContactDelegate

extension ContactViewController: ContactDetailDelegate {
    func update(contact: Contact) {
        contactManager.update(contact)
        tableView.reloadData()
    }
    
    func add(contact: Contact) {
        contactManager.add(contact)
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate

extension ContactViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
}
