//
//  ContactListViewController.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    // MARK: Custom Methods
    private func setUpTableView() {
        contactTableView.delegate = self
        contactTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactInfoModel.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.setUpData(data: ContactInfoModel.sampleData[indexPath.row])
        
        let image = UIImage(systemName: "chevron.right")
        let rightImageView = UIImageView(image: image)
        
        rightImageView.tintColor = .systemGray3
        cell.accessoryView = rightImageView
        
        return cell
    }
}
