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
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    private let contactManager = ContactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        parse()
        setUpNaviBar()
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setUpNaviBar() {
        title = "연락처"
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    private func parse() {
        do {
            try contactManager.parse()
        } catch {
            let alert = showErrorAlert(title: nil, error.localizedDescription, actions: [UIAlertAction(title: "취소", style: .default)])
            present(alert, animated: true)
        }
    }
    @objc func plusButtonTapped() {
        let detailVC = ContactDetailViewController()
        
        detailVC.delegate = self
        
        self.present(UINavigationController(rootViewController: detailVC), animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailCell.identifier , for: indexPath) as? ContactDetailCell else { return UITableViewCell() }
        
        let item = contactManager.contacts[indexPath.row]
        cell.contact = item
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ContactDelegate

extension ContactViewController: ContactDetailDelegate {
    func add(contact: Contact) {
        contactManager.add(contact)
        tableView.reloadData()
    }
}
