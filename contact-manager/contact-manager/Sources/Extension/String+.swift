import Foundation

extension String {
    func trimmed() -> String {
        let whitespaceCharacterSet = CharacterSet.whitespacesAndNewlines
        let trimmedString = self.components(separatedBy: whitespaceCharacterSet).joined()
        return trimmedString
    }
}
