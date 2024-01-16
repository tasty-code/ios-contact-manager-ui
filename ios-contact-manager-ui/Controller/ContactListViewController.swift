//
//  ViewController.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 03/01/2024.
//

import UIKit

final class ContactListViewController: UIViewController {
    
    //MARK: - Properties
    private var contactList: [Contact] = []
    private var numberOfLastRow: Int {
        contactTableView.numberOfRows(inSection: 0)
    }
    
    //MARK: - @IBOutlet
    @IBOutlet private weak var contactTableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureTableView()
        configureNavigationItem()
    }
    
    //MARK: - Custom Methods
    private func configureNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped(_:)))
    }
    
    @objc private func addContactButtonTapped(_ sender: UIButton) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: AddContactViewController.className) as? AddContactViewController else { return }
        
        nextViewController.delegate = self
        
        let navigationViewController = UINavigationController(rootViewController: nextViewController)
        navigationViewController.modalPresentationStyle = .automatic
        
        self.present(navigationViewController, animated: true)
    }
    
    private func configureTableView() {
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
    }
    
    private func addData(with data: Contact) {
        contactList.append(data)
        self.contactTableView.insertRows(at: [IndexPath(row: numberOfLastRow, section: 0)], with: .automatic)
    }
    
    private func scrollToBottom() {
        let lastRowOfIndexPath: Int?
        
        if numberOfLastRow <= 0 {
            lastRowOfIndexPath = NSNotFound
        } else {
            lastRowOfIndexPath = numberOfLastRow - 1
        }
        
        guard let lastRow = lastRowOfIndexPath else { return }

        if lastRow != NSNotFound {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: lastRow, section: 0)
                self.contactTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        } else {
            print("indexPath가 유효하지 않습니다.")
        }
    }
    
    private func loadData() {
        do {
            contactList = try JsonDecoder<[Contact]>().loadData(from: "mockJson", of: "json")
        } catch {
            print("\(JsonParsingError.fileLoadError.ErrorMessage)")
        }
    }
    
    private func modifyTableCell(of selectedCell: String) {
        let selectedCellIndex: Int
        
        guard let selectedCellNumber = Int(selectedCell) else { return }
        
        guard selectedCellNumber >= 0 && selectedCellNumber < numberOfLastRow else { return }
        selectedCellIndex = selectedCellNumber - 1
        
        //contactList[selectedCellIndex] = mockData[0]
        contactTableView.reloadRows(at: [IndexPath(row: selectedCellIndex, section: 0)], with: .fade)
        scrollToBottom()
    }
}

extension ContactListViewController: SendDataDelegate {
    
    func updateContactList(with contact: Contact) {
        addData(with: contact)
    }
}

//MARK: - UITableViewDataSource Extension
extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = contactTableView.dequeueReusableCell(withIdentifier: "contactListCell", for: indexPath)
        
        cell.textLabel?.text = String("\(contactList[indexPath.row].name)" + "(\(contactList[indexPath.row].age))")
        cell.detailTextLabel?.text = contactList[indexPath.row].phoneNumber
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.contactList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

//MARK: - UITableViewDelegate Extension
extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}


