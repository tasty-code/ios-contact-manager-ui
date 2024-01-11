import UIKit

class ContactManager {
    
    static let shared = ContactManager()
    
    private var contactArray: [Contact] = [
        Contact(name: "Alice", age: 22, phoneNumber: "010-1234-5678"),
        Contact(name: "Bob", age: 28, phoneNumber: "010-9876-5432"),
        Contact(name: "Charlie", age: 35, phoneNumber: "010-8765-4321"),
        Contact(name: "David", age: 40, phoneNumber: "010-2345-6789"),
        Contact(name: "Eva", age: 27, phoneNumber: "010-7890-0123"),
        Contact(name: "Frank", age: 33, phoneNumber: "010-3456-7890"),
        Contact(name: "Grace", age: 25, phoneNumber: "010-6789-0123"),
        Contact(name: "Henry", age: 31, phoneNumber: "010-1234-7890"),
        Contact(name: "Ivy", age: 29, phoneNumber: "010-4560-0123"),
        Contact(name: "Jack", age: 26, phoneNumber: "010-9012-3456"),
        Contact(name: "Karen", age: 32, phoneNumber: "010-2103-4567"),
        Contact(name: "Liam", age: 23, phoneNumber: "010-5436-7890"),
        Contact(name: "Mia", age: 36, phoneNumber: "010-7890-0123"),
        Contact(name: "Nathan", age: 30, phoneNumber: "010-2345-6789"),
        Contact(name: "Olivia", age: 28, phoneNumber: "010-8901-2345"),
        Contact(name: "Peter", age: 34, phoneNumber: "010-5678-9012"),
        Contact(name: "Quinn", age: 27, phoneNumber: "010-1234-5678"),
        Contact(name: "Rachel", age: 29, phoneNumber: "010-7890-0123"),
        Contact(name: "Samuel", age: 33, phoneNumber: "010-2345-6789"),
    ]
    
    func createContact(name: String, age: Int, number: String) {
        contactArray.append(Contact(name: name, age: age, phoneNumber: number))
    }
    
    func readContact() -> [Contact] {
        return contactArray
    }
    
    func updateContact(name: String, age: Int, number: String) {
        let contact = Contact(name: name, age: age, phoneNumber: number)
        
        if let result = contactArray.firstIndex(where: { $0.name == name }) {
            contactArray[result] = contact
        }
    }
    
    func deleteContact(name: String) {
        if let index = contactArray.firstIndex(where: { $0.name == name}) {
            contactArray.remove(at: index)
        }
    }
}
