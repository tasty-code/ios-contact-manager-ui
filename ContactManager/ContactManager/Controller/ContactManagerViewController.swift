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
  private let decoder = JSONDecoder()
  private var contacts: [Contact] = []
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
    
    loadData()
  }
  
  private func loadData() {
    do {
      guard let asset = NSDataAsset.init(name: "data") else { return }
      self.contacts = try decoder.decode([Contact].self, from: asset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension ContactManagerViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
    
    cell.configure(model: contacts[indexPath.row])
    return cell
  }
}
