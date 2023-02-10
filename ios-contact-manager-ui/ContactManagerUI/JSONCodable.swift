//
//  JSONCodable.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2/10/23.
//

import Foundation

enum JSONError: Error {
    case FileNotParse
    case FileNotFound
    case FileNotLoad
}

extension JSONError {
    var description: String {
        switch self {
        case .FileNotParse:
            return "JSONFile Parsing 실패"
        case .FileNotFound:
            return "JSONFile Found 실패"
        case .FileNotLoad:
            return "JSONFile Loading 실패"
        }
    }
}

protocol JSONCodable {
    var fileName: String { get }
    func fileURL() throws -> URL
    func encoder<E: Encodable>(data newData: E) throws
    func decoder<D: Decodable>() throws -> D
}

extension JSONCodable {
    func fileURL() throws -> URL {
        guard let result = Bundle.main.url(forResource: self.fileName, withExtension: nil) else {
            throw JSONError.FileNotFound
        }
        return result
    }
    
    func encoder<E: Encodable>(data newData: E) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let updatedData = try encoder.encode(newData)
            try updatedData.write(to: fileURL())
        } catch {
            throw JSONError.FileNotParse
        }
    }
    
    func decoder<D: Decodable>() throws -> D {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            return try decoder.decode(D.self, from: data)
        } catch {
            throw JSONError.FileNotLoad
        }
    }
}
