//
//  ArrayExtension.swift
//  ContactManager
//
//  Created by DONGWOOK SEO on 2023/02/01.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

