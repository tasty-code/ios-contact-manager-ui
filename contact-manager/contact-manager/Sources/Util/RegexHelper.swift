import Foundation

enum RegexHelper {
    static func matchesRegex(_ string: String, regex: RegexPattern) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", String(describing: regex))
        return predicate.evaluate(with: string)
    }
}

enum RegexPattern: CustomStringConvertible {
    case noWhitespace
    case age
    case phoneNumber
    
    var description: String {
        switch self {
        case .noWhitespace:
            "^[\\S]+$"
        case .age:
            "((1\\d)|([1-9]))?\\d"
        case .phoneNumber:
            "^(?=(-?\\d){9,})\\d{2,3}-\\d{3,4}-\\d+$"
        }
    }
}
