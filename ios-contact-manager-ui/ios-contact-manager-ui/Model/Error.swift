//
//  Error.swift
//  ios-contact-manager-ui
//
//  Created by 미르, 루피 on 1/8/24.
//

import Foundation

enum DecoderError: Error, CustomStringConvertible {
    case assetName
    case jsonData
    
    var description: String {
        switch self {
        case .assetName:
            return "에셋네임을 알수 없습니다."
        case .jsonData:
            return "데이터를 알수 없습니다."
        }
    }
}
