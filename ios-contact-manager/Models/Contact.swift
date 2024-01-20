import Foundation

struct Contact {

    static var nextId: Int = 0
    let cid: Int
    let name: String
    let age: Int
    let phoneNumber: String

    init(name: String, age: Int, phoneNumber: String) {
        self.cid = Contact.nextId
        Contact.nextId += 1
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
