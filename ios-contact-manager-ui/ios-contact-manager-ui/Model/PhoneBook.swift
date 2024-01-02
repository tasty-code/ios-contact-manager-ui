
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    let categorizedPhoneBook: [Tag: User]
    
    init(categorizedPhoneBook: [Tag: User]) {
        self.categorizedPhoneBook = categorizedPhoneBook
    }
    
    deinit { print("PhoneBook has been deinit!!")}
}

// MARK: - PhoneBook Method
extension PhoneBook {
    
    func add(user: User) {
        
    }
    
    func remove(user: User) {
        
    }
}
