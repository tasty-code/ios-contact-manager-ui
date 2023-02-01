//
//  ModelData.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

final class ModelData {
    var contacts: [UserInfo] = load("contacts.json") ?? []
}

func load<T: Decodable>(_ fileName: String) -> T? {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        return nil
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        return nil
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        return nil
    }
}
    
