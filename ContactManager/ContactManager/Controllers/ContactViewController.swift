import UIKit
final class ContactViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var contactDTOs: [ContactDTO] = []
    private var filteredName: [String] = []
    private var filteredAge: [String] = []
    private var filteredPhoneNumber: [String] = []
    private let alertController = UIAlertController()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = "하이이이"
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
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredName.count != 0 {
            return filteredName.count
        } else {
            return contactDTOs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
//        print(filteredName.count)
        
        if filteredName.count != 0 {
            let name = filteredName[indexPath.row]
            let age = filteredAge[indexPath.row]
            let phoneNumber = filteredPhoneNumber[indexPath.row]
            
            content.text = "\(name) (\(age))"
            content.secondaryText = phoneNumber
            cell.contentConfiguration = content
            
            return cell
        } else {
            let contactDTOs = contactDTOs[indexPath.row]
            
            let name = contactDTOs.name
            let age = contactDTOs.age
            let phoneNumber = contactDTOs.phoneNumber
            
            content.text = "\(name) (\(age))"
            content.secondaryText = phoneNumber
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        filteredName = []
        filteredAge = []
        filteredPhoneNumber = []
        var names: [String] = []
        var ages: [String] = []
        var phoneNumbers: [String] = []
        
        for element in contactDTOs {
            names.append(element.name)
            ages.append(element.age)
            phoneNumbers.append(element.phoneNumber)
        }
        
        if searchText.isEmpty {
            filteredName = names
            filteredAge = ages
            filteredPhoneNumber = phoneNumbers
        }
        
        for (index, word) in names.enumerated() {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredName.append(word)
                filteredAge.append(ages[index])
                filteredPhoneNumber.append(phoneNumbers[index])
            }
        }
        
        for (index, word) in ages.enumerated() {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredName.append(names[index])
                filteredAge.append(word)
                filteredPhoneNumber.append(phoneNumbers[index])
            }
        }
        
        for (index, word) in phoneNumbers.enumerated() {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredName.append(names[index])
                filteredAge.append(ages[index])
                filteredPhoneNumber.append(word)
            }
        }
        
        tableView.reloadData()
    }
}
