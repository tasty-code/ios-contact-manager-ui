//
//  JSONErrors.swift
//  ContactManager
//
//  Created by Blu on 2023/02/06.
//

import Foundation

enum JSONErrors: Error {
    case notFoundJSONFile
    case notLoadData
    case unableToDecode
    case unableToParse
}
