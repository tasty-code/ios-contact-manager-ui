//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController, UITableViewDelegate {
    private enum Section {
        case main
    }
    
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addViewController = segue.destination as? AddContactViewController else {
            return
        }
        addViewController.newContactDelegate = self
    }

    private func setupTableView() {
        tableView.dataSource = dataSource
        tableView.register(ContactCell.self)
    }
}

extension ContactViewController {
    private func setupDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeue(ContactCell.self, cellForRowAt: indexPath)
            cell.content = itemIdentifier
            return cell
        }
        dataSource?.update(animatingDifferences: false)
    }
}

extension ContactViewController {
    private final class DataSource: UITableViewDiffableDataSource<Section, UserInfo> {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>

        func update(animatingDifferences: Bool) {
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(ContactsController.shared.contacts)
            apply(snapshot, animatingDifferences: animatingDifferences)
        }

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if itemIdentifier(for: indexPath) != nil {
                    ContactsController.shared.remove(index: indexPath.row)
                    update(animatingDifferences: true)
                }
            }
        }
    }
}

extension ContactViewController: NewContactDelegate {
    func addNewContact() {
        dataSource?.update(animatingDifferences: true)
    }
}
