
import UIKit

struct Person {
    var uuid: String
    var name: String
    var age: Int
    var phoneNumber: String
    
    init(name: String, age: Int, phoneNumber: String) {
        self.uuid = UUID().uuidString
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
    }
}
