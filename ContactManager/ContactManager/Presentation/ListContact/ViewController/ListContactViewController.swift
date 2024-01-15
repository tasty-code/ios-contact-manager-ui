//
//  ListContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ListContactViewController: UIViewController {
    private var listContactUseCase: ListContactUseCase?
    
    private weak var coordinator: ListContactViewControllerDelegate?
    
    private let contactListView: ContactListTableView = {
        let tableView = ContactListTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        useCase: ListContactUseCase,
        coordinator: ListContactViewControllerDelegate
    ) {
        self.listContactUseCase = useCase
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.listContactUseCase?.presenter = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.listContactUseCase?.fetchAllContacts()
    }
}

extension ListContactViewController {
    private static let title = "연락처"
    
    private func setupViews() {
        self.title = Self.title
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(contactListView)
        NSLayoutConstraint.activate([
            contactListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        setButtons()
    }
    
    private func setButtons() {
        let action = UIAction { [weak self] _ in self?.startCreating() }
        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func startCreating() {
        self.coordinator?.startAddContact()
    }
}

extension ListContactViewController: ListContactPresentable {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            let contacts = successInfo.contacts.map(ContactListItem.contact)  
            snapshot.appendItems(contacts, toSection: .contact)
        case .failure(let error):
            if let error = error as? LocalizedError {
                print(error.localizedDescription)
            }
            if let error = error as? AlertableError {
                showErrorAlert(error: error)
            }
        }
        self.contactListDataSource.apply(snapshot)
    }
}

extension ListContactViewController: ErrorAlertPresentableViewController {
    private func showErrorAlert(error: AlertableError) {
        switch error {
        case ContactRepositoryError.notFoundAtBundle:
            let action = UIAlertAction(title: "재시도", style: .cancel) { [weak self] _ in
                self?.listContactUseCase?.fetchAllContacts()
            }
            self.presentErrorAlert(error: error, additionalAction: action)
        case ContactRepositoryError.cannotDecode:
            self.presentErrorAlert(error: error)
        default:
            return
        }
    }
}

extension ListContactViewController: ModalViewControllerDismissingHandlable {
    func viewControllerWillAppear() {
        self.listContactUseCase?.fetchAllContacts()
    }
}
