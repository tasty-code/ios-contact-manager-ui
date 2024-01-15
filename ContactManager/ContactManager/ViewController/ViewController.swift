//
//  ViewController.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let contactManager = ContactMananger()
    private let cellIdentifier = "ContactCustomCell"

    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadContactData()
    }
    
    private func configure() {
        self.contactTableView.dataSource = self
    }
    
    private func loadContactData() {
        let decoder = JSONDecoder()
        guard let dataAssets: NSDataAsset = NSDataAsset(name: "Dummy") else { return }
        
        do {
            let dummyData = try decoder.decode([Contact].self, from: dataAssets.data)
            contactManager.initializeContact(contactData: dummyData)
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "알림", message: "데이터 불러오기 실패")
            }
        }
    }
    
    @IBAction func touchUpAddButton(_ sender: UIBarButtonItem) {
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contactCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell: ContactCustomCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ContactCustomCell else { precondition(false, "셀 가져오기 실패")}
        
        let contact = contactManager.fetchContact(index: indexPath.row)
        
        switch contact {
        case .success(let data):
            customCell.nameLabel.text = data.fetchedName
            customCell.ageLabel.text = data.fetchedAge
            customCell.phoneNumberLabel.text = data.fetchedPhoneNumber
        case .failure(let error):
            showAlert(title: "알림", message: error.errorMessage)
        }
        
        return customCell
    }
}
