import Foundation

protocol JSONCodable {
    func decodeJSON() throws -> [ContactDTO]?
}
