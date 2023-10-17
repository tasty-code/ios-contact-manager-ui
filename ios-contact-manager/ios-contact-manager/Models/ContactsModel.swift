import Foundation

final class ContactsModel {
    private var contactsList = [Contact]() {
        didSet {
            self.notifyContactsDidChange()
        }
    }

    var count: Int {
        self.contactsList.count
    }
}

// MARK: CRUD Methods
extension ContactsModel {
    func createContact(contact: Contact) {
        self.contactsList.append(contact)
    }
    
    func readContact(index: Int) -> Contact {
        return self.contactsList[index]
    }
    
    func updateContact(contact: Contact) {
        guard let index = contact.index else { return }
        self.contactsList[index] = contact
    }
    
    func deleteContact(index: Int) {
        self.contactsList.remove(at: index)
    }
}

// MARK: Observer Pattern Methods by using Notification Center
extension ContactsModel {
    private func notifyContactsDidChange() {
        let notificationName = NotificationType.contactsDidChange.name
        NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil)
    }
}
