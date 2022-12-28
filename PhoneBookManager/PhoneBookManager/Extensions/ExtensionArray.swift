//
//  ExtensionArray.swift
//  PhoneBookManager
//
//  Created by 신동오 on 2022/12/27.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
