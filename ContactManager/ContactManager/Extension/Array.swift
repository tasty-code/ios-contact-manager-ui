//
//  Array.swift
//  ContactManager
//
//  Created by Janine on 2023/10/10.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
