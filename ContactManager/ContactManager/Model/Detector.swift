//
//  Detector.swift
//  ContactManager
//
//  Created by 김보미 on 2022/12/22.
//

import Foundation

class Detector {
    func excludeSpaceWord(_ originInputData: [Character]) -> [Character] {
        var filteredData = [Character]()
        
        for element in originInputData {
            if element != " " {
                filteredData.append(element)
            }
        }
        return filteredData
    }
    
    func extractIndexWithSlash(from originInputData: [Character]) -> [Int] {
        var indexCounter = 0
        var dividerIndexesArray = [Int]()
        
        for element in originInputData {
            if element == "/" {
                dividerIndexesArray.append(indexCounter)
            }
            indexCounter += 1
        }
        return dividerIndexesArray
    }
}
