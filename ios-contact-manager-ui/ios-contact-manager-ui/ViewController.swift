//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by JaeHyeok Sim on 2023/10/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let cellIdentifier: String = "cell"
    var addressBook: AddressBook  = AddressBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetting()
    }
    
    private func initialSetting() {
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addressBook.getRowSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let contactData: Contact = addressBook.showContact( indexPath.row)
        cell.textLabel?.text = contactData.name + "(\(contactData.age))"
        cell.detailTextLabel?.text = contactData.phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            addressBook.deleteContact(indexPath.row)
            defer {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension ViewController {
    @IBAction private func TappedAddButton(_ sender: UIBarButtonItem) {
        guard let newContactViewController = storyboard?.instantiateViewController(withIdentifier: "NewContactViewController") as? NewContactViewController else { return }
        newContactViewController.delegate = self
        self.present(newContactViewController, animated: true)
    }
}

extension ViewController: SendDelegate {
    func sendContact(newContact: Contact) {
        self.addressBook.addContact(newContact)
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        addressBook.searchContact(searchText)
        tableView.reloadData()
    }
}
