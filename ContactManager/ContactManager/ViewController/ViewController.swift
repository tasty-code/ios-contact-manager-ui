//
//  ViewController.swift
//  ContactManager
//
//  Created by Jin-Mac on 1/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    let contactManager = ContactMananger()
    let cellIdentifier = "contactCell"

    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        jsonDecoder()
    }
    
    private func configure() {
        self.contactTableView.dataSource = self
    }
    
    private func jsonDecoder() {
        let decoder = JSONDecoder()
        guard let dataAssets: NSDataAsset = NSDataAsset(name: "Dummy") else { return }
        
        do {
            let dummyData = try decoder.decode([Contact].self, from: dataAssets.data)
            contactManager.initalContact(contactData: dummyData)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactManager.contacteCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = contactManager.fetchContact(index: indexPath.row).fetchNameAndAge
        cell.detailTextLabel?.text = contactManager.fetchContact(index: indexPath.row).fetchPhoneNumber
        
        return cell
    }
}
