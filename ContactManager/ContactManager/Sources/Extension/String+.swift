//
//  String+.swift
//  ContactManager
//
//  Created by EUNJU on 2024/01/11.
//

import Foundation

extension String {
    
    func deleteWhiteSpace(_ text: String) -> String {
        let convertedText = text.filter{ $0 != " " }.map{ String($0) }.joined()
        return convertedText
    }
}
