import Foundation

protocol JSONCodable {
    func decodeJSON() -> [ContactDTO]?
}
