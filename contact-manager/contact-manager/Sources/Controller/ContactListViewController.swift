import UIKit

final class ContactListViewController: UIViewController {
    
    private let contactManager: ContactListProvider
    private let tableViewDataSource: ContactListTableViewDataSource
    
    init(contactManager: ContactListProvider) {
        self.contactManager = contactManager
        self.tableViewDataSource = ContactListTableViewDataSource(contacts: contactManager.contacts)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        view.bringSubviewToFront(navigationBar)
    }
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationItem = UINavigationItem(title: "연락처")
        let addContactButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
        navigationItem.rightBarButtonItem = addContactButton
        navigationBar.setItems([navigationItem], animated: false)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBar.standardAppearance = navigationBarAppearance
        return navigationBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension ContactListViewController {
    private func setupNavigationBar() {
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc private func addContactButtonTapped() {
        let newContactViewController = NewContactViewController()
        present(newContactViewController, animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = tableViewDataSource
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
