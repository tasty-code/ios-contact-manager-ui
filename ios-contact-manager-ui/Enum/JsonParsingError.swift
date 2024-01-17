//
//  JsonParsingError.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/9/24.
//

import UIKit

enum JsonParsingError: Error {
    case pathError
    case stringConversionError
    case encodingError
    case decodingError
    case fileLoadError
    
    var errorMessage: String {
        switch self {
        case .pathError:
            "파일의 경로를 읽어오지 못했습니다."
        case .stringConversionError:
            "주어진 파일로부터 문자열 변환에 실패했습니다."
        case .encodingError:
            "문자열을 utf8형식으로 인코딩 하는 것에 실패했습니다."
        case .decodingError:
            "utf8형식의 데이터를 주어진 데이터 타입으로 변환하는 것에 실패했습니다."
        case .fileLoadError:
            "파일을 불러오는 것에 실패했습니다."
        }
    }
}


