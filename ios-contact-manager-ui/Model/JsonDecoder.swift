//
//  JsonDecoder.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/9/24.
//

import UIKit

struct JsonDecoder<Element: Codable> {
    func loadData(from fileName: String, of fileType: String) throws -> Element {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            print("\(JsonParsingError.pathError.ErrorMessage)")
            throw JsonParsingError.pathError }
    
        guard let content = try? String(contentsOfFile: "filePath") else {
            print("\(JsonParsingError.stringConversionError.ErrorMessage)")
            throw JsonParsingError.stringConversionError }
        
        guard let data = content.data(using: .utf8) else { 
            print("\(JsonParsingError.encodingError.ErrorMessage)")
            throw JsonParsingError.encodingError }
        
        guard let jsonData = try? JSONDecoder().decode(Element.self, from: data) else {
            print("\(JsonParsingError.decodingError.ErrorMessage)")
            throw JsonParsingError.decodingError }
        
        return jsonData
    }
}
