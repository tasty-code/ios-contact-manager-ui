import UIKit

extension JSONCodable {
    func decodeJSON(_ contactModel: inout [ContactDTO]?) {
        guard let path = Bundle.main.url(forResource: "ContactJSON", withExtension: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: path) else {
            return
        }

        contactModel = try? JSONDecoder().decode([ContactDTO].self, from: data)
    }
}
