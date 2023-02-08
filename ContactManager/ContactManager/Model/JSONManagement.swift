//
//  JSONManagement.swift
//  ContactManager
//
//  Created by Jason on 2023/02/08.
//

import Foundation

class JSONManangement: JSONParsable {
    func loadJSON<T>(_ filename: String) throws -> T where T : Decodable {
        let data: Data
        
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("\(filename) not found.")
            throw Errors.notFoundJSONFile
        }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            print("Could not load \(filename): (error)")
            throw Errors.notLoadData
        }
        
        do {
            let JSONDecoder = JSONDecoder()
            return try JSONDecoder.decode(T.self, from: data)
        } catch {
            print("Unable to decode \(filename): (error)")
            throw Errors.unableToDecode
        }
    }
    
    func parseJSON() -> [ContactInformation]? {
        guard let parsedInformation: [ContactInformation] = try? loadJSON("Dummy.json") else {
            return nil
        }
        return parsedInformation
    }
}
