//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

final class ContactListViewController: UIViewController {
    var contactListStorage: ContactListStorage?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredDataSource: [ContactList] = []
    private var searchController: UISearchController?
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        self.searchController = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        self.searchController = UISearchController()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "연락처"
        
        tableView.dataSource = self
        tableView.delegate = self
        searchController?.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setNotification()
        filteredDataSource = (contactListStorage?.getContactList())!
    }
    
    @IBAction func addContact(_ sender: Any) {
        moveAddContactView(touch: "버튼")
    }
}

extension ContactListViewController {
    func moveAddContactView(touch: String, rowIndex: Int? = nil) {
        let secondViewController = storyboard?.instantiateViewController(identifier: "AddContactView") { coder in
            return AddContactViewController.init(coder: coder, contactListStorage: self.contactListStorage!)
        }
        if touch == "버튼" {
            moveAddContactViewWithPresent(to: secondViewController)
        }
        else if touch == "테이블 셀" {
            moveAddContactViewWithPush(to: secondViewController, with: rowIndex)
        }
        else {
            return
        }
    }
    
    func moveAddContactViewWithPresent(to secondViewController: AddContactViewController?) {
        secondViewController?.modalTransitionStyle = .coverVertical
        secondViewController?.modalPresentationStyle = .automatic
        let secondNavigationController = UINavigationController(rootViewController: secondViewController!)
        present(secondNavigationController, animated: true)
    }
    
    func moveAddContactViewWithPush(to secondViewController: AddContactViewController?, with rowIndex: Int?) {
        guard let isValidIndex = rowIndex else {
            return
        }
        secondViewController?.tableCellIndex = isValidIndex
        navigationController?.pushViewController(secondViewController!, animated: true)
    }
    
    func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("ModalDismissNC"),
            object: nil
        )
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            print("Test")
        }
    }
}
