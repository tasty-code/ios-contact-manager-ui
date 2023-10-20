//
//  ViewController.swift
//  ContactManager
//
//  Created by 김예준 on 10/6/23.
//

import UIKit

final class ContactManagerViewController: UIViewController {
  // MARK: - Property
  
  @IBOutlet private weak var contactTableView: UITableView!
  private var contacts = [Contact]()
  private var filteredContacts = [Contact]()
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    contactTableView.delegate = self
    contactTableView.dataSource = self
    loadData()
    setupSearchController()
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
}

//MARK: - UITableViewDataSource methods

extension ContactManagerViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredContacts.count : contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
    
    let model = isFiltering ? filteredContacts[indexPath.row] : contacts[indexPath.row]
    cell.configure(model: model)
    return cell
  }
}

//MARK: - UITableViewDelegate methods

extension ContactManagerViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete && isFiltering {
      let removedContact = filteredContacts.remove(at: indexPath.row)
      contacts = contacts.filter { contact in
        contact.uid != removedContact.uid
      }
    } else if editingStyle == .delete {
      contacts.remove(at: indexPath.row)
    }
    
    reload()
  }
  
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    return UISwipeActionsConfiguration()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let editView = storyboard?.instantiateViewController(withIdentifier: "editContactView") as? EditContactViewController else { return }
    
    editView.editContactDelegate = self
    editView.contactChangedDelegate = self
    
    let contactData = isFiltering ? filteredContacts[indexPath.row] : contacts[indexPath.row]
    editView.contactData = contactData
    
    self.present(editView, animated: true)
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

//MARK: - ContactEditDelegate

extension ContactManagerViewController: ContactEditDelegate {
  func editContact(uid: UUID, nameText: String?, ageText: String?, phoneText: String?) throws {
    let (name, age, phone) = try getValidData(nameText: nameText, ageText: ageText, phoneText: phoneText)
    
    filteredContacts = isFiltering ? filteredContacts.map {contact in
      var newContact = contact
      if contact.uid == uid {
        newContact.name = name
        newContact.age = age
        newContact.phone = phone
      }
      return newContact
    } : filteredContacts
    
    filteredContacts = filteredContacts.filter { filteredContact in
      guard let searchText = self.navigationItem.searchController?.searchBar.text else { return true }
      return filteredContact.name.contains(searchText) ||
      String(filteredContact.age).contains(searchText) ||
      filteredContact.phone.contains(searchText)
    }
    
    contacts = contacts.map { contact in
      var newContact = contact
      if contact.uid == uid {
        newContact.name = name
        newContact.age = age
        newContact.phone = phone
      }
      return newContact
    }
  }
}

//MARK: - SearchController

extension ContactManagerViewController: UISearchBarDelegate, UISearchResultsUpdating {
  private var isFiltering: Bool {
    let searchController = self.navigationItem.searchController
    let isActive = searchController?.isActive ?? false
    let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
    return isActive && isSearchBarHasText
  }
  
  private func setupSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "검색할 이름이나 연락처를 입력하세요."
    searchController.automaticallyShowsCancelButton = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchResultsUpdater = self
    
    self.navigationItem.searchController = searchController
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    
    filteredContacts = contacts.filter { contact in
      return contact.name.contains(searchText) ||
      String(contact.age).contains(searchText) ||
      contact.phone.contains(searchText)
    }
    
    reload()
  }
}
