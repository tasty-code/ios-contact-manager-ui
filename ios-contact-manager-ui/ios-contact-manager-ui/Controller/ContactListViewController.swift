
import UIKit

final class ContactListViewController: UIViewController, ContactListDelegate {
    var model: ContactManager? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addContactButton(_ sender: UIBarButtonItem) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.model = self.model
        detailVC.delegate = self
        present(detailVC, animated: true)
    }

    func reloadContactList() {
        self.model?.readContacts()
        self.tableView.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.readContacts().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let data = model?.readContacts()
        let personIndex = data?[indexPath.row]
        
        cell.textLabel?.text = "\(personIndex?.name ?? "")(\(personIndex?.age ?? 0))"
        cell.detailTextLabel?.text = "\(personIndex?.phoneNumber ?? "")"
        cell.accessoryType = .disclosureIndicator
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let list = model?.readContacts()
        let data = list?[indexPath.row]
        
        let action = UIContextualAction(style: .destructive, title: "delete",
                                        handler: {[weak self] (action, view, completionHandler) in
            self?.model?.deletePerson(inputUUID: data?.UUID ?? "")
            self?.reloadContactList()
            completionHandler(true)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
}
