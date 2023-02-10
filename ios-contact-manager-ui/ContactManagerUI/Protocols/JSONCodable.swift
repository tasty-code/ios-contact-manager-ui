//
//  JSONCodable.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2/10/23.
//

import Foundation

enum FileError: Error, LocalizedError {
    case notFound(fileName: String)

    var errorDescription: String? {
        switch self {
        case .notFound(let fileName):
            return "\(fileName) 파일이 존재하지 않습니다."
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
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            throw FileError.notFound(fileName: fileName)
        }
        return url
    }
    
    func encoder<E: Encodable>(data newData: E) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let updatedData = try encoder.encode(newData)
        try updatedData.write(to: fileURL())
    }
    
    func decoder<D: Decodable>() throws -> D {
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: fileURL())
        return try decoder.decode(D.self, from: data)
    }
}
