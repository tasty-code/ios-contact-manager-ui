import UIKit

final class ContactListViewController: UIViewController {
    
    private let contactManager: ContactManager = ContactManager.shared
    private let contactListView: ContactListView = ContactListView()

    private lazy var plusButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, 
                                                      target: self,
                                                      action: #selector(navigationRightItemButtonTapped))
        return button
    }()
}

// MARK: Lifecycle
extension ContactListViewController {
    
    override func loadView() {
        view = contactListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactListView.tableView.delegate = self
        contactListView.tableView.dataSource = self
        setupNavigator()
    }
}

// MARK: Methed
extension ContactListViewController {
    
    private func setupNavigator() {
        let navigationBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        title = CustomViewControllerString.contactListTitleText.description
        navigationItem.rightBarButtonItem = self.plusButton
    }
    
    private func reloadTableView() {
        contactListView.tableView.reloadData()
    }
    
    @objc
    private func navigationRightItemButtonTapped() {
        let detailViewController: DetailContactViewController = DetailContactViewController { [weak self] in
            self?.reloadTableView()
        }
        let navigationController: UINavigationController = UINavigationController(rootViewController: detailViewController)
        self.present(navigationController, animated: true)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension ContactListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.readContact().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomViewControllerString.cellNameText.description, for: indexPath)
        let contactData: [Contact] = contactManager.readContact()
        let contact: Contact = contactData[indexPath.row]
        var customCell: UIListContentConfiguration = cell.defaultContentConfiguration()
        
        customCell.text = "\(contact.name) (\(contact.age))"
        customCell.secondaryText = contact.phoneNumber
        
        cell.contentConfiguration = customCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
}
