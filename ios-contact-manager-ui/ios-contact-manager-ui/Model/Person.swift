
import Foundation

struct Person {
    var UUID: String
    var name: String
    var age: Int
    var phoneNumber: String
    
    init(name: String, age: Int, phoneNumber: String) {
        self.UUID = Foundation.UUID().uuidString
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}

extension Person {
    static func makeStubData() -> [Person] {
        let stub: [Person] = [
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
        return stub
    }
}
