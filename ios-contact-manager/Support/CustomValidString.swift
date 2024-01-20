import Foundation

enum CustomValidString: CustomStringConvertible {
    
    case validDictionaryNameKeyText
    case validDictionaryAgeKeyText
    case validDictionaryPhoneNumberKeyText
    
    case regularExpressionNamePatthenText
    case regularExpressionAgePatthenText
    case regularExpressionPhoneNumberPatthenText
    case regularMatchesText

    
    var description: String {
        switch self {
        case .validDictionaryNameKeyText:
            return "nameValid"
        case .validDictionaryAgeKeyText:
            return "ageValid"
        case .validDictionaryPhoneNumberKeyText:
            return "phoneNumberValid"
            
        case .regularExpressionNamePatthenText:
            return "^[a-zA-Z가-힣]*$"
        case .regularExpressionAgePatthenText:
            return "^[0-9]{1,3}$"
        case .regularExpressionPhoneNumberPatthenText:
            return "^\\d{2,3}-\\d{3,4}-\\d{4}$"
        case .regularMatchesText:
            return "SELF MATCHES %@"
        }
    }
}
