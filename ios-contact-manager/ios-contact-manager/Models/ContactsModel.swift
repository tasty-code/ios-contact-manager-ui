import Foundation

final class ContactsModel {
    private var contactsList: [Contact] = [
        Contact(name: "Alice", age: 30, phoneNumber: 1234567890),
        Contact(name: "Bob", age: 35, phoneNumber: 2345678901),
        Contact(name: "Charlie", age: 28, phoneNumber: 3456789012),
        Contact(name: "David", age: 25, phoneNumber: 4567890123),
        Contact(name: "Eva", age: 32, phoneNumber: 5678901234),
        Contact(name: "Frank", age: 40, phoneNumber: 6789012345),
        Contact(name: "Grace", age: 29, phoneNumber: 7890123456),
        Contact(name: "Helen", age: 31, phoneNumber: 8901234567),
        Contact(name: "Irene", age: 36, phoneNumber: 9012345678),
        Contact(name: "Jack", age: 27, phoneNumber: 0123456789)
    ]

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
