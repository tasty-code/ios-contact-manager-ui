import UIKit

protocol ContactsManagable: AnyObject {
    func updateContact(_ contact: Contact, _ indexPath: IndexPath)
    
    func createContact(_ contact: Contact)
}

final class EditViewController: UIViewController {
    weak var delegate: ContactsManagable?
    var contact: Contact?
    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func touchSaveBarButton(sender: UIBarButtonItem) {
        guard let contact = contact,
              let indexPath = indexPath,
              let delegate = delegate
        else { return }
        delegate.updateContact(contact, indexPath)
    }
}
