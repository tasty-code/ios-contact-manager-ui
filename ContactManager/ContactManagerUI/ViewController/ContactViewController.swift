//
//  ContactViewController.swift
//  ContactManagerUI
//
//  Created by 신동오 on 2023/01/30.
//

import UIKit

final class ContactViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var contactTableView: UITableView!

    private let contactDataSource = ContactDataSource()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Helpers
    private func setupTableView() {
        contactTableView.dataSource = contactDataSource
    }
}
