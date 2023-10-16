import UIKit

final class ContactListViewController: UITableViewController {
    private let contactsModel: ContactsModel = ContactsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserver()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        cell.configureCell(item: contact)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactsModel.readContact(indexPath: indexPath)
        self.presentEditViewController(contact)
    }
    
    @IBAction private func touchAddBarButton(_ sender: UIBarButtonItem) {
        self.presentEditViewController(nil)
    }
    
    private func presentEditViewController(_ contact: Contact?) {
        
        if let contact = contact {
            guard let contactEditViewController = storyboard?.instantiateViewController(withIdentifier: "ContactEditViewController") as? ContactEditViewController else { return }
            contactEditViewController.delegate = self
            contactEditViewController.contact = contact
            self.present(contactEditViewController, animated: true)
        } else {
            guard let contactCreateViewController = storyboard?.instantiateViewController(withIdentifier: "ContactCreateViewController") as? ContactCreateViewController else { return }
            contactCreateViewController.delegate = self
            self.present(contactCreateViewController, animated: true)
        }
    }
}

// MARK: Delegation Methods
extension ContactListViewController: ContactsManagable {
    func createContact(_ contact: Contact) {
        self.contactsModel.createContact(contact: contact)
    }
    
    func updateContact(_ contact: Contact) {
        self.contactsModel.updateContact(contact: contact)
    }
}

// MARK: Observer Pattern Methods by using Notification Center
extension ContactListViewController {
    private func addObserver() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.addObserver(
            forName: Notification.Name(notificationName),
            object: nil,
            queue: nil) { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
}
