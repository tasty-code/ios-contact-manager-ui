//
//  WholeListTableViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import UIKit

final class WholeListTableViewController: UITableViewController {

    private var contactBook = ContactBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPersonContactList()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactBook.rowCountContactList()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath)
        let person = contactBook.bringPersonContact(indexPath)
        
        cell.textLabel?.text = person.name + "(\(person.age))"
        cell.detailTextLabel?.text = person.digits
        
        return cell
    }
    
    @IBAction private func addNewContact(_ sender: Any) {
        guard let addNewContactVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewContactViewController") as? AddNewContactViewController else { return }
        
        addNewContactVC.delegate = self
        
        self.present(addNewContactVC, animated:true, completion: nil)
    }
    
    private func setPersonContactList() {
        contactBook.setContactList([
            Person(name: "Howard", age: "34", digits: "010-1234-1234"),
            Person(name: "Mond", age: "12", digits: "010-1234-1234"),
            Person(name: "Thor", age: "7", digits: "010-1234-1234"),
            Person(name: "Dora", age: "99", digits: "010-1234-1234"),
            Person(name: "JaeHyuk", age: "88", digits: "010-1234-1234")
        ])
    }
}

extension WholeListTableViewController: SendPersonContactData {
    func sendData(name: String, age: String, digits: String) {
        let newPersonContact = Person(name: name, age: age, digits: digits)
        contactBook.addPersonContact(newPersonContact)
        
        tableView.reloadData()
    }
}
