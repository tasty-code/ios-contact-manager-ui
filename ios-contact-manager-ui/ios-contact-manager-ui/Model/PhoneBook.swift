
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    lazy var categorizedBook = [Tag: [User]]()
    
    let dummyUser1 = User(userID: UUID(), name: "김철수", phoneNumber: "010-1111-2223", age: 10)
    let dummyUser2 = User(userID: UUID(), name: "강철수", phoneNumber: "010-1111-2224", age: 20)
    let dummyUser3 = User(userID: UUID(), name: "나철수", phoneNumber: "010-1111-2225", age: 30)
    let dummyUser4 = User(userID: UUID(), name: "미철수", phoneNumber: "010-1111-2226", age: 40)
    let dummyUser5 = User(userID: UUID(), name: "쿠철수", phoneNumber: "010-1111-2227", age: 50)
    let dummyUser6 = User(userID: UUID(), name: "기철수", phoneNumber: "010-1111-2228", age: 60)
    let dummyUser7 = User(userID: UUID(), name: "바철수", phoneNumber: "010-1111-2229", age: 70)
    let dummyUser8 = User(userID: UUID(), name: "비철수", phoneNumber: "010-1111-2221", age: 80)
    let dummyUser9 = User(userID: UUID(), name: "강철수", phoneNumber: "010-1111-2220", age: 90)
    let dummyUser10 = User(userID: UUID(), name: "자철수", phoneNumber: "010-1111-2202", age: 100)

    deinit { print("PhoneBook has been deinit!!")}
    
}

// MARK: - PhoneBook Method
extension PhoneBook {
    
    func add(user: User) {
        
    }
    
    func remove(user: User) {
        
    }
}
