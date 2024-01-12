//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/2/24.
//

import UIKit

protocol ContactDelegate: AnyObject {
    func add(contact: Contact)
}

final class ContactViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        return button
    }()
    
    private let contactManger = ContactManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        parse()
        configure()
        registerCell()
        setUpNaviBar()
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)])
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setUpNaviBar() {
        title = "연락처"
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    private func parse() {
        do {
            contactManger.contacts = try AssetDecoder<[Contact]>().parse(assetName: "MOCK_DATA")
        } catch {
            let alert = showErrorAlert(title: nil, error.localizedDescription, actions: [UIAlertAction(title: "취소", style: .default)])
            present(alert, animated: true)
        }
    }
    
    @objc func plusButtonTapped() {
        let detailVC = ContactDetailViewController()
        detailVC.modalPresentationStyle = UIModalPresentationStyle.automatic
        
        detailVC.delegate = self
        
        self.present(detailVC, animated: true)
    }
}

extension ContactViewController {
    private func registerCell() {
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManger.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier , for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        let item = contactManger.contacts[indexPath.row]
        cell.contact = item
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ContactViewController: ContactDelegate {
    func add(contact: Contact) {
        contactManger.add(contact: contact)
        tableView.reloadData()
    }
}
