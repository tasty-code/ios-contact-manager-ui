//
//  Extension+UserInfo.swift
//  ContactManagerUI
//
//  Created by 송선진 on 2023/02/01.
//

import Foundation

extension UserInfo: CellFormat {
    var mainText: String {
        return "\(name) (\(age))"
    }
    
    var subText: String {
        return "\(phone)"
    }
}
