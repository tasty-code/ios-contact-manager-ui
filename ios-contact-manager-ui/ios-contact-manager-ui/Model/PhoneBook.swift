
import Foundation

protocol updatePhoneBookDelegate: AnyObject {
    func onUpdate()
}

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {
    
    weak var delegate: updatePhoneBookDelegate?
    
    @NotifyContactInfoChange
    var categorizedContactInfo: [User] = [
        User(userID: UUID(), name: "전종혁", phoneNumber: "010-1111-2224", age: 20),
        User(userID: UUID(), name: "강차수", phoneNumber: "010-1111-2224", age: 20),
        User(userID: UUID(), name: "김궁구", phoneNumber: "010-1111-2223", age: 10),
        User(userID: UUID(), name: "나철수", phoneNumber: "010-1112-2223", age: 10),
        User(userID: UUID(), name: "남희수", phoneNumber: "010-1113-2224", age: 20),
        User(userID: UUID(), name: "당긍수", phoneNumber: "010-1212-2223", age: 30),
        User(userID: UUID(), name: "다로수", phoneNumber: "010-1513-2224", age: 40),
        User(userID: UUID(), name: "자철수", phoneNumber: "010-1112-2223", age: 10),
        User(userID: UUID(), name: "증철수", phoneNumber: "010-1113-2224", age: 20),
        User(userID: UUID(), name: "하철수", phoneNumber: "010-1112-2243", age: 3),
    ]
    
    init() {
        _categorizedContactInfo.updateChange = { [weak self] in
            self?.delegate?.onUpdate()
        }
    }
    
    deinit { print("PhoneBook has been deinit!!")}
}


