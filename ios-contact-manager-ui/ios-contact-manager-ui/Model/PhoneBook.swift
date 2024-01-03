
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    lazy var categorizedBook: [Tag: User] = [.friend: dummyUser1]
    
    let dummyUser1 = User(userID: UUID(), name: "김철수", phoneNumber: "010-1111-2222", age: 20)
        
    deinit { print("PhoneBook has been deinit!!")}
    
}

// MARK: - PhoneBook Method
extension PhoneBook {
    
    func add(user: User) {
        
    }
    
    func remove(user: User) {
        
    }
}
