import UIKit
final class ContactViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var contactDTOs: [ContactDTO] = []
    private let alertController = UIAlertController()
    
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
        return contactDTOs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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
