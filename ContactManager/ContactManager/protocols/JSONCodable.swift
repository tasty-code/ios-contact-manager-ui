import Foundation

protocol JSONCodable {
    func decodeJSON(_ contactModel: inout [ContactModel]?)
}
