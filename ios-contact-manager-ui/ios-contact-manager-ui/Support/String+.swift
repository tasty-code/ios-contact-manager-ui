
import UIKit

extension String {
    func addPhoneNumberHyphen() -> String {
        var formatText = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        guard !formatText.isEmpty else {
            return ""
        }

        let hyphen: Character = "-"

        if formatText.hasPrefix("02") {
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
        } else {
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
        }
        return formatText
    }
}
