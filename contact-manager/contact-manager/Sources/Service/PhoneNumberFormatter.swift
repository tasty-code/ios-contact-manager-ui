import Foundation

enum PhoneNumberFormatter {
    case threeOrTwelveDigits, fourOrSixDigits, sevenOrTenDigits, elevenDigits
    case twoOrElevenDigits, threeOrFiveDigits, sixOrNineDigits, tenDigits
    
    static let predefinedAreaCodes = ["010", "031", "032", "033", "041", "042", "043", "051", "052", "053", "054", "055", "061", "062", "063", "064"]
    
    init?(digitCount: Int, areaCode: String) {
        if PhoneNumberFormatter.predefinedAreaCodes.contains(areaCode) {
            switch digitCount {
            case 3, 12: self = .threeOrTwelveDigits
            case 4, 6: self = .fourOrSixDigits
            case 7, 10: self = .sevenOrTenDigits
            case 11: self = .elevenDigits
            default: return nil
            }
        } else {
            switch digitCount {
            case 2, 11: self = .twoOrElevenDigits
            case 3, 5: self = .threeOrFiveDigits
            case 6, 9: self = .sixOrNineDigits
            case 10: self = .tenDigits
            default: return nil
            }
        }
    }
    
    func formatting(digits: String) -> String {
        switch self {
        case .threeOrTwelveDigits, .twoOrElevenDigits:
            return digits
        case .fourOrSixDigits:
            return applyFormattingPattern("(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2")
        case .sevenOrTenDigits:
            return applyFormattingPattern("(\\d{3})(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2-$3")
        case .elevenDigits:
            return applyFormattingPattern("(\\d{3})(\\d{4})(\\d{4})", toDigits: digits, withTemplate: "$1-$2-$3")
        case .threeOrFiveDigits:
            return applyFormattingPattern("(\\d{2})(\\d)", toDigits: digits, withTemplate: "$1-$2")
        case .sixOrNineDigits:
            return applyFormattingPattern("(\\d{2})(\\d{3})(\\d)", toDigits: digits, withTemplate: "$1-$2-$3")
        case .tenDigits:
            return applyFormattingPattern("(\\d{2})(\\d{4})(\\d{4})", toDigits: digits, withTemplate: "$1-$2-$3")
        }
    }
    
    private func applyFormattingPattern(_ pattern: String, toDigits digits: String, withTemplate template: String) -> String {
        let regex = try? NSRegularExpression(pattern: pattern)
        let nsRange = NSRange(location: 0, length: digits.count)
        return regex?.stringByReplacingMatches(in: digits, range: nsRange, withTemplate: template) ?? digits
    }
}
