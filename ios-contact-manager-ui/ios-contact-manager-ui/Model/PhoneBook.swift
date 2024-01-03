
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    let categorizedBook: [Tag: User] = [:]
        
    deinit { print("PhoneBook has been deinit!!")}
}

// MARK: - PhoneBook Method
extension PhoneBook {
    
    func add(user: User) {
        
    }
    
    func remove(user: User) {
        
    }
}
