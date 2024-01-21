//
//  ListContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ListContactViewController: UIViewController {
    enum ListState {
        case noContacts
        case noSearchingResults
        case noProblem
    }
    
    private var listContactUseCase: ListContactUseCase?
    
    private weak var coordinator: ListContactViewControllerDelegate?
    
    private let contactListView: ContactListTableView = {
        let tableView = ContactListTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    private var searchController: UISearchController?
    
    private var listIsEmpty: ListState = .noProblem {
        didSet {
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
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
        self.contactListView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.listContactUseCase?.fetchAllContacts()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            switch self.listIsEmpty {
            case .noContacts:
                self.contentUnavailableConfiguration = ContactUnavailableConfiguration.noContacts
            case .noSearchingResults:
                self.contentUnavailableConfiguration = ContactUnavailableConfiguration.noSearchingResults
            case .noProblem:
                self.contentUnavailableConfiguration = nil
            }
        }
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
        setSearchController()
    }
    
    private func setButtons() {
        let action = UIAction { [weak self] _ in self?.didTapCreateButton() }
        let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func setSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func didTapCreateButton() {
        self.coordinator?.startAddContact()
    }
    
    private func handle(error: Error) {
        if let error = error as? LocalizedError {
            print(error.localizedDescription)
        }
        if let error = error as? AlertableError {
            showErrorAlert(error: error)
        }
    }
}

extension ListContactViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard let listItem = contactListDataSource.itemIdentifier(for: indexPath) else { return nil }
        switch listItem {
        case .contact(let contact):
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
                self.listContactUseCase?.deleteContact(contactID: contact.id)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let listItem = contactListDataSource.itemIdentifier(for: indexPath) else { return }
        switch listItem {
        case .contact(let contact):
            self.coordinator?.startUpdateContact(contactID: contact.id)
        }
    }
}

extension ListContactViewController: ListContactPresentable {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            self.listIsEmpty = .noProblem
            let contacts = successInfo.contacts.map(ContactListItem.contact)
            snapshot.appendItems(contacts, toSection: .contact)
        case .failure(let error):
            self.listIsEmpty = .noContacts
            handle(error: error)
        }
        self.contactListDataSource.apply(snapshot)
    }
    
    func presentDeleteContact(result: Result<Void, Error>) {
        switch result {
        case .success:
            self.listContactUseCase?.fetchAllContacts()
        case .failure(let error):
            handle(error: error)
        }
    }
    
    func presentSearchContact(result: Result<ListContact.SuccessInfo, Error>) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            self.listIsEmpty = .noProblem
            let contacts = successInfo.contacts.map(ContactListItem.contact)
            snapshot.appendItems(contacts, toSection: .contact)
        case .failure(let error):
            self.listIsEmpty = .noSearchingResults
            handle(error: error)
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

extension ListContactViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query.isEmpty == false else {
            self.listContactUseCase?.fetchAllContacts()
            return
        }
        self.listContactUseCase?.searchContact(with: query)
    }
}
