protocol JSONCodable {
    func decodeJSON() throws -> [ContactDTO]?
}
