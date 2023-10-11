import Foundation

protocol JSONCodable {
    func decodeJSON(_ contactModel: inout [ContactDTO]?)
}
