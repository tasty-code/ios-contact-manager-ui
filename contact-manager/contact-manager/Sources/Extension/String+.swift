extension String {
    func trimmed() -> String {
        self.replacing(/\s/, with: "")
    }
}
