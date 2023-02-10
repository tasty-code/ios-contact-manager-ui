//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {
    enum Section {
        case main
    }
    private let modelData = ModelData()
    @IBOutlet private weak var tableView: UITableView!
    private var dataSource: DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
    }
}

extension ContactViewController {
    private func setupDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let identifier = "ContactCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ContactCell else {
                fatalError("\(identifier) cell is not registered!")
            }
            cell.content = itemIdentifier
            return cell
        }

        dataSource?.update(animatingDifferences: false)
    }
}


extension ContactViewController: UITableViewDelegate {

}

extension ContactViewController {
    final class DataSource: UITableViewDiffableDataSource<Section, UserInfo> {
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>

        func update(animatingDifferences: Bool) {
            var snapshot = Snapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(ModelData.shared.contacts)
            apply(snapshot, animatingDifferences: animatingDifferences)
        }

        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if itemIdentifier(for: indexPath) != nil {
                    ModelData.shared.remove(index: indexPath.row)
                    update(animatingDifferences: true)
                }
            }
        }
    }
}
