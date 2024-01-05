
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    var categorizedBook = 
    [
     0: [
        User(userID: UUID(), name: "김철수", phoneNumber: "010-1111-2223", age: 10),
        User(userID: UUID(), name: "강철수", phoneNumber: "010-1111-2224", age: 20)
        ],
     1 :[
        User(userID: UUID(), name: "나철수", phoneNumber: "010-1112-2223", age: 10),
        User(userID: UUID(), name: "남철수", phoneNumber: "010-1113-2224", age: 20)
        ],
     2 :[
        User(userID: UUID(), name: "당철수", phoneNumber: "010-1212-2223", age: 30),
        User(userID: UUID(), name: "다철수", phoneNumber: "010-1513-2224", age: 40)
        ]
    ]
    
    deinit { print("PhoneBook has been deinit!!")}
}

// MARK: - PhoneBook Method
extension PhoneBook {
    
    func add(user: User) {
        
    }
    
    func remove(user: User) {
        
    }
}
