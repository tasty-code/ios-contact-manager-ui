//
//  ViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

class ContactManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  @IBOutlet weak var contactTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
  
}

