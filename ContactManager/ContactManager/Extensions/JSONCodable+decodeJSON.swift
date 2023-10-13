import UIKit

extension JSONCodable {
    func decodeJSON() throws -> [ContactDTO]? {
        guard let path = Bundle.main.url(forResource: "ContactJSON", withExtension: "json") else {
            throw DecodingErrors.invaildPath
        }
        
        guard let data = try? Data(contentsOf: path) else {
            throw DecodingErrors.invaildData
        }
        
        guard let contactDTO = try? JSONDecoder().decode([ContactDTO].self, from: data) else {
            throw DecodingErrors.invaildDecoding
        }
            
        return contactDTO
    }
}
