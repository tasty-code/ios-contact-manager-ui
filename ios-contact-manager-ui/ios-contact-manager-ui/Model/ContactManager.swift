
import UIKit

final class ContactManager {
    static let shared = ContactManager()
    private init() {}
    
    private var contactList: [Person] = [
        Person(name: "Alice", age: 22, phoneNumber: "010-1234-5678"),
        Person(name: "Bob", age: 28, phoneNumber: "010-9876-5432"),
        Person(name: "Charlie", age: 35, phoneNumber: "010-8765-4321"),
        Person(name: "David", age: 40, phoneNumber: "010-2345-6789"),
        Person(name: "Eva", age: 27, phoneNumber: "010-7890-0123"),
        Person(name: "Frank", age: 33, phoneNumber: "010-3456-7890"),
        Person(name: "Grace", age: 25, phoneNumber: "010-6789-0123"),
        Person(name: "Henry", age: 31, phoneNumber: "010-1234-7890"),
        Person(name: "Ivy", age: 29, phoneNumber: "010-4560-0123"),
        Person(name: "Jack", age: 26, phoneNumber: "010-9012-3456"),
        Person(name: "Karen", age: 32, phoneNumber: "010-2103-4567"),
        Person(name: "Liam", age: 23, phoneNumber: "010-5436-7890"),
        Person(name: "Mia", age: 36, phoneNumber: "010-7890-0123"),
        Person(name: "Nathan", age: 30, phoneNumber: "010-2345-6789"),
        Person(name: "Olivia", age: 28, phoneNumber: "010-8901-2345"),
        Person(name: "Peter", age: 34, phoneNumber: "010-5678-9012"),
        Person(name: "Quinn", age: 27, phoneNumber: "010-1234-5678"),
        Person(name: "Rachel", age: 29, phoneNumber: "010-7890-0123"),
        Person(name: "Samuel", age: 33, phoneNumber: "010-2345-6789")
    ]
    
    
    // MARK: 모델 기능
    func readContacts() -> [Person] {
        return contactList
    }
    
    func addPerson(person: Person) {
        contactList.append(person)
    }
    
    func deletePerson(inputUuid: String) {
        if let index = contactList.firstIndex(where: { $0.uuid == inputUuid }) {
            contactList.remove(at: index)
        }
    }
    
    func editContact(inputUuid: String, inputName: String, inputAge: Int, inputPhone: String) {
        if let index = contactList.firstIndex(where: { $0.uuid == inputUuid }) {
            contactList[index].name = inputName
            contactList[index].age = inputAge
            contactList[index].phoneNumber = inputPhone
        }
    }
}
