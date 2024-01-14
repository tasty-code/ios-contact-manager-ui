extension String {
    func trimmed() -> String {
        self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
}
