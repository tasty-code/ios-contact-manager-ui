//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    //MARK: - Properties
    private var contactList: [Contact] = []
    private var filteredContacts: [Contact] = []
    private var searchController = UISearchController(searchResultsController: nil)
    private var isSearchActive: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    private var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        configureNavigationItem()
        configureSearchBar()
    }
    
    //MARK: - Custom Methods
    private func configureSearchBar() {
        searchController.searchBar.placeholder = "이름, 나이 및 연락처를 검색합니다."
        searchController.searchBar.showsCancelButton = false
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "연락처"
        lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addContactButtonTapped(_ sender: UIButton) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: AddContactViewController.className) as? AddContactViewController else { return }
        
        nextViewController.delegate = self
        
        let navigationViewController = UINavigationController(rootViewController: nextViewController)
        navigationViewController.modalPresentationStyle = .automatic
        
        self.present(navigationViewController, animated: true)
    }
    
    private func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    private func addData(with data: Contact) {
        contactList.append(data)
        filteredContacts.append(data)
        self.contactTableView.insertRows(at: [IndexPath(row: numberOfLastRow, section: 0)], with: .automatic)
    }
    
//    private func scrollToBottom() {
//        let lastRowOfIndexPath: Int?
//        
//        if numberOfLastRow <= 0 {
//            lastRowOfIndexPath = NSNotFound
//        } else {
//            lastRowOfIndexPath = numberOfLastRow - 1
//        }
//        
//        guard let lastRow = lastRowOfIndexPath else { return }
//        
//        if lastRow != NSNotFound {
//            DispatchQueue.main.async {
//                let indexPath = IndexPath(row: lastRow, section: 0)
//                self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//            }
//        } else {
//            print("indexPath가 유효하지 않습니다.")
//        }
//    }
    
    private func loadData() {
        do {
            contactList = try JsonDecoder<[Contact]>().loadData(from: "mockJson", of: "json")
            filteredContacts = contactList
        } catch {
            print("\(JsonParsingError.fileLoadError.errorMessage)")
            print("\(JsonParsingError.fileLoadError.localizedDescription)")
        }
    }
    
//    private func modifyTableCell(of selectedCell: String) {
//        let selectedCellIndex: Int
//
//        guard let selectedCellNumber = Int(selectedCell) else { return }
//
//        guard selectedCellNumber >= 0 && selectedCellNumber < numberOfLastRow else { return }
//        selectedCellIndex = selectedCellNumber - 1
//
//        //contactList[selectedCellIndex] = mockData[0]
//        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
//        scrollToBottom()
//    }
}

extension ContactListViewController: AddContactDelegate {
    
    func updateContactList(with contact: Contact) {
        addData(with: contact)
    }
}

//MARK: - UITableViewDataSource Extension
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredContacts.count : contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath)
        let contact = isSearchActive ? filteredContacts[indexPath.row] : contactList[indexPath.row]
        cell.textLabel?.text = String("\(contact.name)" + "(\(contact.age))")
        cell.detailTextLabel?.text = contact.phoneNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isSearchActive {
            contactList.removeAll { $0 == filteredContacts[indexPath.row] }
            self.filteredContacts.remove(at: indexPath.row)
        } else {
            self.contactList.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - UITableViewDelegate Extension
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

//MARK: - UISearchBarUpdating Extension
extension ContactListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.isEmpty == false else {
            filteredContacts = contactList
            contactTableView.reloadData()
            return
        }
        
        filteredContacts = contactList.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.age.contains(searchText) ||
            $0.phoneNumber.contains(searchText) ||
            $0.phoneNumber.extractNumbersFromStrings().contains(searchText)
        }
        
        contactTableView.reloadData()
    }
}


