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
    var addressBook: AddressBook  = AddressBook()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }
    
    func initialSetting() {
        self.tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension ViewController {
    @IBAction func TappedAddButton(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "NewContactViewController") as? NewContactViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension ViewController: SendDelegate {
    func sendContact(newContact: Contact) {
        self.addressBook.addContact(newContact)
        self.tableView.reloadData()
    }
}
