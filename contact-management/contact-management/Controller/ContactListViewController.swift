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
        moveAddContactView(transitionStyle: UIModalTransitionStyle.coverVertical, presentationStyle: UIModalPresentationStyle.automatic)
    }
}

extension ContactListViewController {
    func moveAddContactView(transitionStyle: UIModalTransitionStyle, presentationStyle: UIModalPresentationStyle) {
        let secondViewController = storyboard?.instantiateViewController(identifier: "AddContactView") { coder in
            return AddContactViewController.init(coder: coder, contactListStorage: self.contactListStorage!)
        }
        secondViewController?.modalTransitionStyle = transitionStyle
        secondViewController?.modalPresentationStyle = presentationStyle
        
        let secondNavigationController = UINavigationController(rootViewController: secondViewController!)
        present(secondNavigationController, animated: true)
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
