//
//  ContactManagerTableViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/01/31.
//

import UIKit

var contactInfomation = [String: Any]()
var nameArray = [String]()
var ageArray = [String]()
var phoneNumberArray = [String]()

final class ContactManagerTableViewController: UITableViewController {
    
    @IBOutlet private weak var contactManagerTableView: UITableView!
    private var contactDataSource = ContactDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        parseJSON()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self.contactDataSource
    }
    
    private func parseJSON() {
        guard let filePath = Bundle.main.url(forResource: "Dummy", withExtension: "json") else { return }
        
        if let data = try? Data(contentsOf: filePath) {
            let json =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            contactInfomation = json
        }
        
        if let contactInfo = contactInfomation["Dummy"] as? [[String: Any]] {
            contactInfo.forEach { contactData in
                nameArray.append(contactData["name"] as! String)
                ageArray.append(contactData["age"] as! String)
                phoneNumberArray.append(contactData["phoneNumber"] as! String)
            }
        }
    }
}

final class ContactDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "infoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.configurationUpdateHandler = { cell, state in
            var infoContent = cell.defaultContentConfiguration().updated(for: state)
            infoContent.text = "\(nameArray[indexPath.row])(\(ageArray[indexPath.row]))"
            infoContent.secondaryText = phoneNumberArray[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = infoContent
        }
        return cell
    }
}
