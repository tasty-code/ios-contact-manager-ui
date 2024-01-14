//
//  Formatter.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

//protocol InputFormattable {
//    func format(_ input: String) -> String
//}
//
//struct InputFormatter: InputFormattable {
//    private let format: (String) -> String
//    
//    func format(_ input: String) -> String {
//        return self.format(input)
//    }
//}

typealias InputFormatter = (String) -> FormattingResult

struct FormattingResult {
    let formatted: String
    let validationError: ValidationError?
}

