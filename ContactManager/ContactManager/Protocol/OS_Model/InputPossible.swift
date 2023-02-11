//
//  InputPossible.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/23.
//

import Foundation

protocol InputPossible {
    func userInputValue() -> String
}

extension InputPossible {
    func userInputValue() -> String {
        guard let userInput = readLine() else {
            return "F"
        }
        return userInput
    }
}
