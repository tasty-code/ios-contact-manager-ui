import UIKit

final class TableViewController: UITableViewController {
    private let contactsModel: ContactsModel = ContactsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeEditedContact()
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
        self.presentModallyEditViewController(contact, indexPath)
    }
    
    @IBAction private func touchAddBarButton(_ sender: UIBarButtonItem) {
        self.presentModallyEditViewController(nil, nil)
    }
    
    private func presentModallyEditViewController(_ contact: Contact?, _ indexPath: IndexPath?) {
        guard let editViewController = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController else { return }
        
        editViewController.indexPath = indexPath
        editViewController.contact = contact
        
        self.present(editViewController, animated: true)
    }
}

// MARK: Observer Pattern by using Notification Center
extension TableViewController {
    private func observeEditedContact() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(NotificationType.createContact.name),
            object: nil,
            queue: nil) { [weak self] notification in
                guard let contact = notification.object as? Contact else { return }
                self?.contactsModel.createContact(contact: contact)
                self?.tableView.reloadData()
            }
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(NotificationType.updateContact.name),
            object: nil,
            queue: nil) { [weak self] notification in
                guard let object = notification.object as? (contact: Contact, indexPath: IndexPath) else { return }
                let contact = object.contact
                let indexPath = object.indexPath
                self?.contactsModel.updateContact(contact: contact, indexPath: indexPath)
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
    }
}
