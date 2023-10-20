import UIKit

final class ContactListViewController: UITableViewController {
    private let contactsModel: ContactsModel = ContactsModel()
    private var filteredContactList: [Contact] = []

    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        
        guard let isActive = searchController?.isActive else { return false }
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        
        return isActive && isSearchBarHasText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserver()
        configureSearchController()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltering ? self.filteredContactList.count : self.contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        if self.isFiltering {
            let contact = self.filteredContactList[indexPath.row]
            cell.configureCell(item: contact)
        } else {
            let contact = self.contactsModel.readContact(index: indexPath.row)
            cell.configureCell(item: contact)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var contact = self.contactsModel.readContact(index: indexPath.row)
        contact = Contact(name: contact.name, age: contact.age, phoneNumber: contact.phoneNumber, index: indexPath.row)
        self.presentEditViewController(contact)
    }
    
    @IBAction private func touchAddBarButton(_ sender: UIBarButtonItem) {
        self.presentCreateViewController()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            self.contactsModel.deleteContact(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    private func presentCreateViewController() {
        guard let contactCreateViewController = storyboard?.instantiateViewController(identifier: "ContactCreateViewController", creator: { coder in
            return ContactCreateViewController(coder: coder)
        }) else { return }
        contactCreateViewController.delegate = self
        self.present(contactCreateViewController, animated: true)
    }
    
    private func presentEditViewController(_ contact: Contact) {
        guard let contactEditViewController = storyboard?.instantiateViewController(identifier: "ContactEditViewController", creator: { coder in
            return ContactEditViewController(coder: coder, contact: contact)
        }) else { return }
        contactEditViewController.delegate = self
        self.present(contactEditViewController, animated: true)
    }
}

// MARK: Delegation Methods
extension ContactListViewController: ContactFormViewControllerDelegate  {
    func createContact(_ contactCreateViewController: ContactCreateViewController, _ contact: Contact) {
        self.contactsModel.createContact(contact: contact)
    }
    
    func updateContact(_ contactEditViewController: ContactEditViewController, _ contact: Contact) {
        self.contactsModel.updateContact(contact: contact)
    }
}

// MARK: Observer Pattern Methods by using Notification Center
extension ContactListViewController {
    private func addObserver() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.addObserver(
            forName: Notification.Name(notificationName),
            object: nil,
            queue: nil) { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
}

extension ContactListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        
        self.filteredContactList = self.contactsModel.readContactList().filter { $0.name.localizedCaseInsensitiveContains(text) }
        
            self.tableView.reloadData()
    }
    
    
    func configureSearchController() {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "이름 검색"
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController = searchController
        
    }
}
