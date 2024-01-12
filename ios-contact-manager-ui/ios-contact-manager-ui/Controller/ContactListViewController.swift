
import UIKit

class ContactListViewController: UIViewController {
    let model = ContactManager.shared
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addContectButton(_ sender: UIBarButtonItem) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        present(detailVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}
    
extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.readContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let data = model.readContacts()
        let personIndex = data[indexPath.row]
        
        cell.textLabel?.text = "\(personIndex.name)(\(personIndex.age))"
        cell.detailTextLabel?.text = "\(personIndex.phoneNumber)"
        cell.accessoryType = .disclosureIndicator
        
        cell.selectionStyle = .none
        
        return cell
    }
}
