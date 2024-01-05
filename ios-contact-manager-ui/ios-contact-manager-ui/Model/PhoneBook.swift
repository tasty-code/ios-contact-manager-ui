
import Foundation

// MARK: - PhoneBooks Init & Deinit
final class PhoneBook {

    let nameIndex = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    // Key값은 nameIndex의 순서와 동일
    var categorizedContactInfo = [
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
        ],
        8 :[
            User(userID: UUID(), name: "자철수", phoneNumber: "010-1112-2223", age: 10),
            User(userID: UUID(), name: "증철수", phoneNumber: "010-1113-2224", age: 20)
        ],
        13 :[
            User(userID: UUID(), name: "하철수", phoneNumber: "010-1112-2243", age: 3),
            User(userID: UUID(), name: "흠철수", phoneNumber: "010-1113-2254", age: 10)
        ],
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
