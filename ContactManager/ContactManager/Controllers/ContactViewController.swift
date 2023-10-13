import UIKit
final class ContactViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    var contactDTOs: [ContactDTO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dummyContactDTOs = decodeJSON() {
            contactDTOs = dummyContactDTOs
        }
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @available(iOS 16.0, *)
    @IBAction func touchUpAddButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "NewContactViewController") as? NewContactViewController else {
            return
        }
        nextVC.delegate = self
        present(nextVC, animated: true)
    }
}

extension ContactViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactDTOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
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

extension ContactViewController: DataSendable {
    func send(_ data: ContactDTO) {
        contactDTOs.append(data)
        tableView.reloadData()
    }
}

extension ContactViewController: JSONCodable { }

extension ContactViewController: UITableViewDelegate { }
