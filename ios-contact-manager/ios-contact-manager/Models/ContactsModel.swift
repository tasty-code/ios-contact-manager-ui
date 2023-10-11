import Foundation

final class ContactsModel {
    private var contactsList = [Contact]()

    var count: Int {
        self.contactsList.count
    }
}

// MARK: CRUD Methods
extension ContactsModel {
    func createContact(contact: Contact) {
        self.contactsList.append(contact)
    }
    
    func readContact(indexPath: IndexPath) -> Contact {
        return self.contactsList[indexPath.row]
    }
    
    func updateContact(contact: Contact, indexPath: IndexPath) {
        self.contactsList[indexPath.row] = contact
    }
    
    func deleteContact(indexPath: IndexPath) {
        self.contactsList.remove(at: indexPath.row)
    }
}
