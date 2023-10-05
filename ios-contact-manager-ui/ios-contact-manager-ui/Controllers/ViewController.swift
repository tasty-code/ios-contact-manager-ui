//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 김진웅 on 2023/10/04.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    private let contactManager = ContactManager()
    private let cellIdentifier = "ContactCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDummyData()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contactsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! ContactCell
        let contact = contactManager.showContact(index: indexPath.row)
        cell.titleLabel.text = "\(contact.name)(\(contact.age))"
        cell.subtitleLabel.text = "\(contact.phoneNumber)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactManager.showContact(index: indexPath.row)
        print(contact.name)
        print(contact.age)
        print(contact.phoneNumber)
        print("|---------------|")
    }
    
}

extension ViewController {
    func makeDummyData() {
        for i in 1...30 {
            let name = "사용자 \(i)"
            let age = Int.random(in: 20...60)
            let phoneNumber = "010-1234-3455"
            
            contactManager.addContact(name, age, phoneNumber)
        }
    }
}


