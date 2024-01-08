//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var contactList: [Contact] = [
        Contact(name: "Harry", age: 20, phoneNumber: "010-1234-5678"),
        Contact(name: "Hoi", age: 20, phoneNumber: "010-0000-0000"),
        Contact(name: "Dio", age: 20, phoneNumber: "010-1111-1111")
    ]
    
    var mockData: [Contact] = [ Contact(name: "목업", age: 99, phoneNumber: "010-9999-9999") ]
    
    var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    @IBOutlet weak var contactTableView: UITableView!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    @IBAction func addButtonTapped() {
        addMockData()
        scrollToBottom()
    }
            
    func addMockData() {
        contactList.append(mockData[0])
        self.contactTableView.reloadData()
    }
    
    func scrollToBottom() {
        let lastRowOfIndexPath = numberOfLastRow - 1
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
            self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        return cell
    }
}

