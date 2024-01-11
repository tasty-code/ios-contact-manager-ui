import UIKit

final class ContactListTableViewDataSource: NSObject, UITableViewDataSource {
    private var contacts: [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell else {
            fatalError("ContactCell load Failed")
        }
        let contact = contacts[indexPath.row]
        cell.configure(with: contact)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
}
