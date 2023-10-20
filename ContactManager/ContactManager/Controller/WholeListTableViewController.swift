//
//  WholeListTableViewController.swift
//  ContactManager
//
//  Created by 전성수 on 10/5/23.
//

import UIKit

final class WholeListTableViewController: UITableViewController {
    
    private var contactBook = ContactBook()
    private var searchFilterdList: [Person] = []
    private let contactCellIdentifier: String = "ContactInformationCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearching: Bool {
        let isActive = searchController.isActive
        let isSearchBarHasText = searchController.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setPersonContactList()
    }
    
    @IBAction private func moveToAddNewContact(_ sender: Any) {
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
    
    private func setUpSearchController() {
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "이름을 입력해주세요"
        searchController.searchResultsUpdater  = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.sizeToFit()
    }
}

extension WholeListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchFilterdList.count
        } else {
            return contactBook.rowCountContactList()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactCellIdentifier, for: indexPath) as? ContactInformationTableViewCell
        else { return ContactInformationTableViewCell() }
        let personContact = contactBook.bringPersonContact(indexPath)
        
        if isSearching {
            let personContactSearched = searchFilterdList[indexPath.row]
            cell.drawCell(personContactSearched)
        } else {
            cell.drawCell(personContact)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            contactBook.deletePersonContact(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
extension WholeListTableViewController: PersonContactUpdating {
    func updateNewPersonContact(name: String, age: String, digits: String) {
        let newPersonContact = Person(name: name, age: age, digits: digits)
        contactBook.addPersonContact(newPersonContact)
        self.tableView.reloadData()
    }
}


extension WholeListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        searchFilterdList = self.contactBook.personContactList.filter {
            $0.name.localizedCaseInsensitiveContains(text)
        }
        
        tableView.reloadData()
    }
}
