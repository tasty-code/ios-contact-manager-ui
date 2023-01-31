//
//  ContactManagerTableViewController.swift
//  ContactManagerUI
//
//  Created by Blu on 2023/01/31.
//

import UIKit

var contactInfomation = [String: Any]()
var nameArr = [String]()
var ageArr = [String]()
var phoneNumberArr = [String]()

class ContactManagerTableViewController: UITableViewController {
    
    @IBOutlet private weak var contactManagerTableView: UITableView!
    private var contactDataSource = ContactDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testJSON()
        self.configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self.contactDataSource
    }
    
    private func testJSON() {
        let fullPath = "/Users/kh_lee/Desktop/SeSac/ios-contact-manager-ui/ContactManager/ContactManager/Storage/Dummy.json"
        
        if let data = try? String(contentsOfFile: fullPath).data(using: .utf8) {
            let json =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            contactInfomation = json
        }
        
        if let contactInfo = contactInfomation["Dummy"] as? [[String: Any]] {
            for contactInfoIndex in contactInfo {
                nameArr.append(contactInfoIndex["name"] as! String)
                ageArr.append(contactInfoIndex["age"] as! String)
                phoneNumberArr.append(contactInfoIndex["phoneNumber"] as! String)
            }
        }
    }
}

class ContactDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "infoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.configurationUpdateHandler = { cell, state in
            var infoContent = cell.defaultContentConfiguration().updated(for: state)
            infoContent.text = "\(nameArr[indexPath.row])(\(ageArr[indexPath.row]))"
            infoContent.secondaryText = phoneNumberArr[indexPath.row]
            
            cell.accessoryType = .disclosureIndicator
            cell.contentConfiguration = infoContent
        }
        return cell
    }
}
