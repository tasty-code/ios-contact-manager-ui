//
//  Formatter.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

typealias InputFormatter = (String) -> FormattingResult

struct FormattingResult {
    let formatted: String
    let validationError: ValidationError?
}
