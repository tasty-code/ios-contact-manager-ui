enum InputValidator {
    static func isValidName(_ name: String) -> Bool {
        return RegexHelper.matchesRegex(name, regex: RegexPattern.noWhitespace)
    }
    
    static func isValidAge(_ age: String) -> Bool {
        return RegexHelper.matchesRegex(age, regex: RegexPattern.age)
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        return RegexHelper.matchesRegex(phoneNumber, regex: RegexPattern.phoneNumber)
    }
}
