//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellIdentifier: String = "cell"
    var addressBook: AddressBook!  = AddressBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        addressBook.addContact(Contact(name: "dora", phoneNumber: "010-0000-0000", age: 100))
        addressBook.addContact(Contact(name: "jaehyeok", phoneNumber: "010-1111-1111", age: 200))
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addressBook.getSectionSize()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressBook.getRowSize(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let contactData: Contact = addressBook.showContact(indexPath.section, indexPath.row)
        
        cell.textLabel?.text = contactData.name + "(\(contactData.age))"
        cell.detailTextLabel?.text = contactData.phoneNumber
        
        return cell
    }
}


