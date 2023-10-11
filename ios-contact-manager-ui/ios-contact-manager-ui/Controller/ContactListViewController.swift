//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김준성 on 2023/10/04.
//

import UIKit

final class ContactListViewController: UIViewController {
    private let contactManager = ContactManager()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.tableView.dataSource = self
        
        for i in 0...100 {
            try! contactManager.add(Contact(name: "123", age: i, phoneNumber: "123-123-1234"))
        }
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "연락처"
        self.navigationItem.rightBarButtonItem = buildAddButton()
    }
    
    private func buildAddButton() -> UIBarButtonItem {
        let addButton = UIBarButtonItem(systemItem: .add)
        addButton.target = self
        addButton.action = #selector(tapAddButton(_:))
        return addButton
    }
    
    @objc private func tapAddButton(_ sender: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "EditContactViewController")
                as? EditContactViewController
        else {
            print("error")
            return
        }
        
        present(UINavigationController(rootViewController: viewController), animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "ContactCell"
        let contact = contactManager.contacts[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? ContactCell else {
            let cell = ContactCell(style: .subtitle, reuseIdentifier: id)
            cell.configureCell(contact)
            return cell
        }
        cell.configureCell(contact)
        return cell
    }
}

