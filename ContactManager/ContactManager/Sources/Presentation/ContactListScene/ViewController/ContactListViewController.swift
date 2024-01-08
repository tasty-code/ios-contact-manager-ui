//
//  ContactListViewController.swift
//  ContactManager
//
//  Created by 둘리 on 2024/01/03.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    // MARK: Properties
    let sampleData: [ContactInfoModel] = [
        ContactInfoModel(name: "james", age: 30, phoneNumber: "05-343-2234"),
        ContactInfoModel(name: "steven", age: 100, phoneNumber: "047-221-3432"),
        ContactInfoModel(name: "hajin", age: 33, phoneNumber: "010-333-23122"),
        ContactInfoModel(name: "tom", age: 23, phoneNumber: "2313-23-232"),
        ContactInfoModel(name: "tomi", age: 23, phoneNumber: "123-123-123"),
        ContactInfoModel(name: "jane", age: 99, phoneNumber: "6988-768-788"),
        ContactInfoModel(name: "july", age: 32, phoneNumber: "05-2222-3234"),
        ContactInfoModel(name: "eren", age: 220, phoneNumber: "123-13-423"),
        ContactInfoModel(name: "gom", age: 53, phoneNumber: "010-222-36722"),
        ContactInfoModel(name: "jin", age: 73, phoneNumber: "683-2543-233432"),
        ContactInfoModel(name: "saejun", age: 42, phoneNumber: "1889-793-677"),
        ContactInfoModel(name: "jinyoung", age: 19, phoneNumber: "111-2222-33333-444"),
        ContactInfoModel(name: "mike", age: 60, phoneNumber: "05-343-2256564"),
        ContactInfoModel(name: "nero", age: 90, phoneNumber: "45457-2221-3432"),
        ContactInfoModel(name: "easy", age: 13, phoneNumber: "0220-333-65122"),
        ContactInfoModel(name: "matthew", age: 63, phoneNumber: "22133-23-23446452"),
        ContactInfoModel(name: "sidi", age: 72, phoneNumber: "968763-123-123"),
        ContactInfoModel(name: "den", age: 09, phoneNumber: "0293-233-1111")
    ]
    
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
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.className, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.configureUI()
        cell.setUpData(data: sampleData[indexPath.row])

        return cell
    }
}
