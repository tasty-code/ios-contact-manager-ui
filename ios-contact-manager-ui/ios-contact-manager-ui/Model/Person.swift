
import UIKit

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
