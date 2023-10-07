import UIKit
final class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JSONCodable {
    
    @IBOutlet private weak var tableView: UITableView!
    private var contactDTO: [ContactDTO]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decodeJSON(&contactDTO)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let peopleCount = contactDTO?.count else {
            return 0
        }
        return peopleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        
        guard let name = contactDTO?[indexPath.row].name,
              let age = contactDTO?[indexPath.row].age,
              let phoneNumber = contactDTO?[indexPath.row].phoneNumber 
        else {
            return UITableViewCell()
        }
        
        content.text = "\(name) (\(age))"
        content.secondaryText = phoneNumber
        cell.contentConfiguration = content
        
        return cell
    }
}
