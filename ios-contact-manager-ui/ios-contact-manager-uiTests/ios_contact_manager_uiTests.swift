//
//  ios_contact_manager_uiTests.swift
//  ios-contact-manager-uiTests
//
//  Created by 김준성 on 2023/10/04.
//

import XCTest
@testable import ios_contact_manager_ui

final class ios_contact_manager_uiTests: XCTestCase {
    let contactValidityChecker = ContactValidityChecker()
    
    // MARK: - 이름
    func test_이름_빈_문자열인지() {
        let result = contactValidityChecker.checkNameValidation("")
        XCTAssertEqual(result, nil)
    }
    
    func test_이름_띄어쓰기_제거되는지() {
        let names = [
            (input: "j ames", output: "james"),
            (input: "j ame s", output: "james"),
            (input: "j a m e s", output: "james"),
            (input: "쫑", output: "쫑"),
            (input: "팜 하니", output: "팜하니"),
            (input: "뉴진스 ", output: "뉴진스"),
            (input: " 뉴진스 ", output: "뉴진스"),
        ]
        
        for name in names {
            XCTAssertEqual(contactValidityChecker.checkNameValidation(name.input), name.output)
        }
    }
    
    // MARK: - 나이
    func test_나이_빈_문자열인지() {
        
    }
    
    func test_나이_띄어쓰기_제거되는지() {
        
    }
    
    func test_나이_숫자로_변환되는지() {
        
    }
    
    func test_나이_100살_미만인지() {
        
    }
    
    // MARK: - 연락처
    func test_연락처_빈_문자열인지() {
        
    }
    
    func test_연락처_길이가_11자리인지() {
        
    }
    
    func test_연락처_하이픈이_정확히_2개인지() {
        
    }
    
    func test_연락처_하이픈이_2개_연속으로_있는지() {
        
    }
    
    func test_연락처_하이픈_제거하면_숫자만_있는지() {
        
    }
}
