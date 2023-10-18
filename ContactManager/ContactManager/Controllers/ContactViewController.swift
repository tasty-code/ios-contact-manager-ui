import UIKit
final class ContactViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var contactDTOs: [ContactDTO] = []
    private var filteredContact = FilteredContact()
    
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
        if filteredContact.names.count != 0 {
            return filteredContact.names.count
        } else {
            return contactDTOs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
        let name = filteredContact.names.count == 0 ? contactDTOs[indexPath.row].name : filteredContact.names[indexPath.row]
        let age = contactDTOs[indexPath.row].age
        let phoneNumber = filteredContact.phoneNumbers.count == 0 ? contactDTOs[indexPath.row].phoneNumber : filteredContact.phoneNumbers[indexPath.row]
        
        content.text = "\(name) (\(age))"
        content.secondaryText = phoneNumber
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactDTOs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        filteredContact.names = []
        filteredContact.phoneNumbers = []
        
        let names: [String] = contactDTOs.map { $0.name }
        let ages: [String] = contactDTOs.map { $0.age }
        let phoneNumbers: [String] = contactDTOs.map { $0.phoneNumber }
        
        if searchText.isEmpty {
            filteredContact.names = names
            filteredContact.phoneNumbers = phoneNumbers
        }
    
        for (index, word) in names.enumerated() {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredContact.names.append(word)
                filteredContact.ages.append(ages[index])
                filteredContact.phoneNumbers.append(phoneNumbers[index])
            }
        }
        
        for (index, word) in phoneNumbers.enumerated() {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredContact.names.append(names[index])
                filteredContact.ages.append(ages[index])
                filteredContact.phoneNumbers.append(word)
            }
        }
        
        tableView.reloadData()
    }
}
