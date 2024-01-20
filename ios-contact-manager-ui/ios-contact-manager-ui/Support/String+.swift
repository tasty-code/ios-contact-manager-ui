
import Foundation

extension String {
    func addPhoneNumberHyphen() -> String {
        var text = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let hyphen: Character = "-"
        
        guard !text.isEmpty else {
            return ""
        }
        
        if text.hasPrefix("02") {
            text = addHyphenSeoulNumber(text, hyphen)
        } else {
            text = addHyphenNumber(text, hyphen)
        }
        return text
    }
    
    func addHyphenSeoulNumber(_ text: String, _ hyphen: Character) -> String {
        var formatText = text
        
        switch formatText.count {
        case 3...5:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
        case 6...9:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
            formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: 6 - formatText.count))
        case 10:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
            formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: -4))
        default:
            break
        }
        return formatText
    }
    
    func addHyphenNumber(_ text: String, _ hyphen: Character) -> String {
        var formatText = text
        
        switch formatText.count {
        case 4...6:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
        case 7...10:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
            formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: 7 - formatText.count))
        case 11:
            formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
            formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: -4))
        default:
            break
        }
        return formatText
    }
}
