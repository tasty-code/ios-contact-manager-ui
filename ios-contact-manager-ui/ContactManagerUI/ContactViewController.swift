//
//  ViewController.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    private let dataSource = TableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

extension ContactViewController: UITableViewDelegate {

}
