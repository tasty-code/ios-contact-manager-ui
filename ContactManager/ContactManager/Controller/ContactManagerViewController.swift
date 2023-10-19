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
  private var contacts = [Contact]()
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
    loadData()
  }
  
  @IBAction private func addContactTapped(_ sender: UIBarButtonItem) {
    guard let addContactView = storyboard?.instantiateViewController(withIdentifier: "addContactView") as? AddContactViewController else { return }
    addContactView.contactAddDelegate = self
    addContactView.contactChangedDelegate = self
    
    self.present(addContactView, animated: true)
  }
  
  private func loadData() {
    do {
      let decoder = JSONDecoder()
      guard let asset = NSDataAsset.init(name: "data") else { return }
      self.contacts = try decoder.decode([Contact].self, from: asset.data)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  private func getValidData(nameText: String?, ageText: String?, phoneText: String?) throws -> (String, Int, String) {
    let name = try nameText.getValidName()
    let age = try ageText.getValidAge()
    let phone = try phoneText.getValidPhone()
    
    return (name: name, age: age, phone: phone)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      contacts.remove(at: indexPath.row)
      reload()
    }
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return UISwipeActionsConfiguration()
  }
}

//MARK: - UITableViewDataSource

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

//MARK: - ContactAddDelegate

extension ContactManagerViewController: ContactAddDelegate {
  func addContact(nameText: String?, ageText: String?, phoneText: String?) throws {
    let (name, age, phone) = try getValidData(nameText: nameText, ageText: ageText, phoneText: phoneText)
    let data = Contact(name: name, age: age, phone: phone)
    contacts.append(data)
  }
}

//MARK: - ContactChangedDelegate

extension ContactManagerViewController: ContactChangedDelegate {
  func reload() {
    contactTableView.reloadData()
  }
}
