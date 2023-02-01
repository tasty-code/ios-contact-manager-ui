//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/01/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        contactTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockupContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contactTableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        let name = mockupContacts[indexPath.row].name
        let age = mockupContacts[indexPath.row].age
        let phoneNumber = mockupContacts[indexPath.row].phoneNumber
        cell.titleLabel.text = "\(name)(\(age))"
        cell.subTitleLabel.text = phoneNumber

        return cell
    }
    
    
}


