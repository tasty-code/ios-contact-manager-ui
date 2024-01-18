
import UIKit

final class ContactManager {
    var contactList = [Person]()
    
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
