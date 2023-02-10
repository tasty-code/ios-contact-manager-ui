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
    private var dataSource: UITableViewDiffableDataSource<Section, UserInfo>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

extension ContactViewController {
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, UserInfo>(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let identifier = "contactCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
                fatalError("cannot provide cell..")
            }
            var content = cell.defaultContentConfiguration()
            content.text = itemIdentifier.text
            content.secondaryText = itemIdentifier.secondaryText
            cell.contentConfiguration = content
            return cell
        }

        let contacts = modelData.contacts
        var snapshot = NSDiffableDataSourceSnapshot<Section, UserInfo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contacts)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}


extension ContactViewController: UITableViewDelegate {

}
