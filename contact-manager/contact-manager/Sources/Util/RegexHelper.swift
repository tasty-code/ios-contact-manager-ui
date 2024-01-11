import Foundation

enum RegexHelper {
    static func matchesRegex(_ string: String, regex: RegexPattern) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", String(describing: regex))
        return predicate.evaluate(with: string)
    }
}

enum RegexPattern: CustomStringConvertible {
    case noWhitespace
    case onlyNumbers
    case phoneNumber
    
    var description: String {
        switch self {
        case .noWhitespace:
            "^[\\S]+$"
        case .onlyNumbers:
            "^\\d{1,3}$"
        case .phoneNumber:
            "^(?=(?:\\D*\\d){9,})\\d+-\\d+-\\d+$"
        }
    }
}
