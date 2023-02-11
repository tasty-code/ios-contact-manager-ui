//
//  Checkable.swift
//  ContactManager
//
//  Created by Blu on 2023/02/09.
//

import Foundation

protocol Checkable {
    func checkCorrect(targets: [String]) -> [Bool]
    func checkCorrectWord(target: [String]) -> ContactInformation?
}
