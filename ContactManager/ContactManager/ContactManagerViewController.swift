//
//  ViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

class ContactManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var contactTableView: UITableView!
  let decoder = JSONDecoder()
  
  var contacts: [Contact] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
    guard let asset = NSDataAsset.init(name: "data") else { return }
    
    do {
      self.contacts = try decoder.decode([Contact].self, from: asset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
    cell.nameLabel.text = contacts[indexPath.row].nameAndAge
    cell.phoneLabel.text = contacts[indexPath.row].phone
    return cell
  }
  
}

