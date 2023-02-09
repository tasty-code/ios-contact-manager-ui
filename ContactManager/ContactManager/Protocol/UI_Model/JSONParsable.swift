//
//  JSONParsable.swift
//  ContactManager
//
//  Created by Jason on 2023/02/08.
//

import Foundation

protocol JSONParsable {
    func loadJSON<T: Decodable>(_ filename: String) throws -> T
    func parseJSON() -> [ContactInformation]?
}
