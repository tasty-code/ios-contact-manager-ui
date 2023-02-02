//
//  ModelData.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

final class ModelData {
    // TODO: Error 처리하기
    private(set) var contacts: [UserInfo] = (try? load("contacts.json")) ?? []
}

func load<T: Decodable>(_ fileName: String) throws -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        throw ContactError.FileNotFound
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        throw ContactError.FileNotLoad
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw ContactError.FileNotParse
    }
}
    
