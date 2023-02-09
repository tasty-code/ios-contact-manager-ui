//
//  Convertable.swift
//  ContactManager
//
//  Created by Blu on 2023/02/09.
//

import Foundation

protocol Convertable {
    func renderToCharacter(_ sentence: String) -> [Character]
    func renderToString(_ characters: [Character]) -> String
}
