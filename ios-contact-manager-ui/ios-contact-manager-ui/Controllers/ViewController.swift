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
    func makeDummyData() {
        guard let path = Bundle.main.path(forResource: "Contacts", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
              let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] else {
            return
        }
        
        for (_, item) in jsonArray.enumerated() {
            guard let name = item["name"] as? String,
                  let age = item["age"] as? String,
                  let phoneNumber = item["phoneNumber"] as? String else {
                continue
            }
            
            do {
                try contactManager.addContact(name, age, phoneNumber)
            } catch {
                print("\(name) \(age) \(phoneNumber)")
                print(String(describing: error))
            }
        }
    }
}


