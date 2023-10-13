//
//  ViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

final class ContactManagerViewController: UIViewController, UITableViewDelegate {
  // MARK: - Property
  
  @IBOutlet private weak var contactTableView: UITableView!
  private let manager = ContactManager()
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
    
    NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("AddContact"), object: nil)
  }
  
  @objc private func reload() {
    contactTableView.reloadData()
  }
  
  @IBAction func addContactTapped(_ sender: UIBarButtonItem) {
    guard let addContactView = storyboard?.instantiateViewController(
      identifier: "addContactView", creator: { creater in
        let viewController = AddContactViewController(coder: creater, manager: self.manager)
        return viewController
      }) else { return }

    self.present(addContactView, animated: true)
  }
}

extension ContactManagerViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return manager.getContacts().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
    let contacts = manager.getContacts()
    
    cell.configure(model: contacts[indexPath.row])
    return cell
  }
}
