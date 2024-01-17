import Foundation

enum PhoneNumberFormatter {
    static func format(unformatted phoneNumberText: String) -> String? {
        let digits = phoneNumberText.replacingOccurrences(of: "-", with: "")
        guard digits.count >= 2 else {
            return nil
        }
        
        let areaCode = String(digits.prefix(3))
        guard let phoneNumberType = PhoneNumberType(areaCode: areaCode) else {
            return nil
        }
        
        return formatDigits(digits, for: phoneNumberType)
    }
}

extension PhoneNumberFormatter {
    private enum PhoneNumberType {
        case threeAreaCodeNumber
        case twoAreaCodeNumber
        
        private static let threeAreaCodes = ["010", "031", "032", "033", "041", "042", "043", "051", "052", "053", "054", "055", "061", "062", "063", "064"]
        
        init?(areaCode: String) {
            if PhoneNumberType.threeAreaCodes.contains(areaCode) {
                self = .threeAreaCodeNumber
            } else {
                self = .twoAreaCodeNumber
            }
        }
    }
}

extension PhoneNumberFormatter {
    private static func formatDigits(_ digits: String, for phoneNumberType: PhoneNumberType) -> String? {
        switch phoneNumberType {
        case .threeAreaCodeNumber:
            return formatForThreeAreaCodeNumber(digits: digits)
        case .twoAreaCodeNumber:
            return formatForTwoAreaCodeNumber(digits: digits)
        }
    }
    
    private static func formatForThreeAreaCodeNumber(digits: String) -> String? {
        switch digits.count {
        case 3, 12:
            return digits
        case 4, 6:
            return applyFormattingPattern("(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2")
        case 7, 10:
            return applyFormattingPattern("(\\d{3})(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2-$3")
        case 11:
            return applyFormattingPattern("(\\d{3})(\\d{4})(\\d{4})", toDigits: digits, withTemplate: "$1-$2-$3")
        default:
            return nil
        }
    }
    
    private static func formatForTwoAreaCodeNumber(digits: String) -> String? {
        switch digits.count {
        case 2, 11:
            return digits
        case 3, 5:
            return applyFormattingPattern("(\\d{2})(\\d)", toDigits: digits, withTemplate: "$1-$2")
        case 6, 9:
            return applyFormattingPattern("(\\d{2})(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2-$3")
        case 10:
            return applyFormattingPattern("(\\d{2})(\\d{4})(\\d{4})", toDigits: digits, withTemplate: "$1-$2-$3")
        default:
            return nil
        }
    }
    
    private static func applyFormattingPattern(_ pattern: String, toDigits digits: String, withTemplate template: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern)
        let nsRange = NSRange(location: 0, length: digits.count)
        return regex?.stringByReplacingMatches(in: digits, range: nsRange, withTemplate: template)
    }
}
