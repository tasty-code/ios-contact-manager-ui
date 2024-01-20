import Foundation

extension String {
    func addPhoneNumberHyphen() -> String {
        let formatText: String = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        guard !formatText.isEmpty else {
            return ""
        }
        return formatTextVaildCheck(formatText: formatText)
    }
    
    private func formatTextVaildCheck(formatText: String) -> String {
        var editingText = formatText
        let hyphen: Character = "-"
        if editingText.hasPrefix("02") {
            switch editingText.count {
            case 3...5:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 2))
            case 6...9:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 2))
                editingText.insert(hyphen, at: editingText.index(editingText.endIndex, offsetBy: 6 - editingText.count))
            case 10:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 2))
                editingText.insert(hyphen, at: editingText.index(editingText.endIndex, offsetBy: -4))
            default:
                break
            }
        } else {
            switch editingText.count {
            case 4...6:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 3))
            case 7...10:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 3))
                editingText.insert(hyphen, at: editingText.index(editingText.endIndex, offsetBy: 7 - editingText.count))
            case 11:
                editingText.insert(hyphen, at: editingText.index(editingText.startIndex, offsetBy: 3))
                editingText.insert(hyphen, at: editingText.index(editingText.endIndex, offsetBy: -4))
            default:
                break
            }
        }
        return editingText
    }
}
