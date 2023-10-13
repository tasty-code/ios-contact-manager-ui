import UIKit

extension JSONCodable {
    func decodeJSON() -> [ContactDTO]? {
        guard let path = Bundle.main.url(forResource: "ContactJSON", withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: path) else {
            return nil
        }
        
        let contactDTO = try? JSONDecoder().decode([ContactDTO].self, from: data)
        
        return contactDTO
    }
}
