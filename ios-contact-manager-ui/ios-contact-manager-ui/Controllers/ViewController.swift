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
        
        setDummyData()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contactsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        let contact = contactManager.showContact(index: indexPath.row)
        cell.textLabel?.text = "\(contact.name)(\(contact.age))"
        cell.detailTextLabel?.text = "\(contact.phoneNumber)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController {
    func setDummyData() {
        guard let path = Bundle.main.path(forResource: "Contacts", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return }
        let decoder = JSONDecoder()
        
        do {
            let contacts = try decoder.decode([Contact].self, from: jsonData)
            for contact in contacts {
                try contactManager.addContact(contact)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


