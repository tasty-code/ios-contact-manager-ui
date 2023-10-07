import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JSONCodable {

    @IBOutlet weak var tableView: UITableView!
    var contactModel: [ContactModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decodeJSON(&contactModel)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let peopleCount = contactModel?.count else {
            return 0
        }
        return peopleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        // 리팩터링 할 부분
//        cell.textLabel?.text = contactModel![indexPath.row].name + "(" + contactModel![indexPath.row].age + ")"
//        cell.detailTextLabel?.text = contactModel![indexPath.row].phoneNumber
        
        return cell
    }
}


