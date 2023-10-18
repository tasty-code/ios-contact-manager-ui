import UIKit
final class ContactViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var contactDTOs: [ContactDTO] = []
    private var filteredContact: [ContactDTO] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        loadDelegate()
    }
    
    @available(iOS 16.0, *)
    @IBAction private func touchUpAddButton(_ sender: Any) {
        guard let newContactViewController
                = self.storyboard?.instantiateViewController(identifier: "NewContactViewController")
                as? NewContactViewController else {
            return
        }
        newContactViewController.delegate = self
        present(newContactViewController, animated: true)
    }
    
    private func loadJSON() {
        let alertController = UIAlertController()
        do {
            if let dummyContactDTOs = try decodeJSON() {
                contactDTOs = dummyContactDTOs
            }
        }
        catch {
            alertController
                .configureAlertController(title: "데이터 불러오기 실패",
                                          message: nil,
                                          defaultAction: "예",
                                          destructiveAction: nil,
                                          viewController: self)
        }
    }
    
    private func loadDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "찾을 사람을 검색하세요."
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredContact.count != 0 {
            return filteredContact.count
        } else {
            return contactDTOs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
        let contact = filteredContact.count == 0 ? contactDTOs[indexPath.row] : filteredContact[indexPath.row]
        
        let name = contact.name
        let age = contact.age
        let phoneNumber = contact.phoneNumber
        
        content.text = "\(name) (\(age))"
        content.secondaryText = phoneNumber
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if filteredContact.count != 0 {
                let contact = filteredContact.remove(at: indexPath.row)
                for index in 0..<contactDTOs.count {
                    if contactDTOs[index].name == contact.name {
                        contactDTOs.remove(at: index)
                        break
                    }
                }
                
                if filteredContact.isEmpty {
                    searchBar.text = ""
                }
                
                tableView.reloadData()
            } else {
                contactDTOs.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension ContactViewController: DataSendable {
    func send(_ data: ContactDTO) {
        contactDTOs.append(data)
        let indexPath = IndexPath(row: self.contactDTOs.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}

extension ContactViewController: JSONCodable { }

extension ContactViewController: UITableViewDelegate { }

extension ContactViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContact = contactDTOs.filter({
            $0.name.localizedCaseInsensitiveContains(searchText) ||  $0.phoneNumber.localizedCaseInsensitiveContains(searchText)
        })
    
        tableView.reloadData()
    }
}
