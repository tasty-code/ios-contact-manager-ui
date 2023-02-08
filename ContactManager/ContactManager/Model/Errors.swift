//
//  Errors.swift
//  ContactManager
//
//  Created by Blu on 2023/02/06.
//

import Foundation

enum Errors: Error {
    case notFoundJSONFile
    case notLoadData
    case unableToDecode
    case unableToParse
}
