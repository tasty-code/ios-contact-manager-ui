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
            (input: " ", output: nil),
            (input: "  ", output: nil),
            (input: "j ames", output: "james"),
            (input: "j ame s", output: "james"),
            (input: "j a m e s", output: "james"),
            (input: "쫑", output: "쫑"),
            (input: "팜 하니", output: "팜하니"),
            (input: "뉴진스 ", output: "뉴진스"),
            (input: " 뉴진스 ", output: "뉴진스")
        ]
        
        for name in names {
            XCTAssertEqual(contactValidityChecker.checkNameValidation(name.input), name.output)
        }
    }
    
    // MARK: - 나이
    func test_나이_빈_문자열인지() {
        let age = ""
        XCTAssertEqual(age, nil)
    }
    
    func test_나이_띄어쓰기_제거되는지() {
        let ages = [
            (input: " ", output: nil),
            (input: "  ", output: nil),
            (input: "3 5", output: 35),
            (input: " 35", output: 35),
            (input: "35 ", output: 35),
            (input: "35 ", output: 35)
        ]
        
        for age in ages {
            XCTAssertEqual(contactValidityChecker.checkAgeValidation(age.input), age.output)
        }
    }
    
    func test_나이_숫자로_변환되는지() {
        let ages = [
            (input: " ", output: nil),
            (input: "  ", output: nil),
            (input: "a b", output: nil),
            (input: "a 3", output: nil),
            (input: "3 a 5", output: nil),
            (input: "3 5", output: 35),
            (input: " 35", output: 35),
            (input: "35 ", output: 35),
            (input: "35 ", output: 35)
        ]
        
        for age in ages {
            XCTAssertEqual(contactValidityChecker.checkAgeValidation(age.input), age.output)
        }
    }
    
    func test_나이_100살_미만인지() {
        let ages = [
            (input: "35", output: 35),
            (input: "100", output: nil),
            (input: "99", output: 99),
            (input: "-1", output: nil),
            (input: "0", output: nil),
            (input: "1", output: 1)
        ]
        
        for age in ages {
            XCTAssertEqual(contactValidityChecker.checkAgeValidation(age.input), age.output)
        }
    }
    
    // MARK: - 연락처
    func test_연락처_빈_문자열인지() {
        XCTAssertEqual(contactValidityChecker.checkPhoneNumberValidation(""), nil)
    }
    
    func test_연락처_길이가_11자리_이상인지() {
        let phoneNumbers = [
            (input: "111", output: nil),
            (input: "111-11-11", output: nil),
            (input: "1-1-1-1-1", output: nil),
            (input: "111-1111-111", output: "111-1111-111"),
            (input: "111-1111-1111", output: "111-1111-1111"),
            (input: "111-1111-11111", output: "111-1111-11111")
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertEqual(contactValidityChecker.checkPhoneNumberValidation(phoneNumber.input), phoneNumber.output)
        }
    }
    
    func test_연락처_하이픈이_정확히_2개인지() {
        let phoneNumbers = [
            (input: "111", output: nil),
            (input: "111-111", output: nil),
            (input: "1-1-1-111", output: nil),
            (input: "111-1111-1111", output: "111-1111-1111"),
            (input: "111-1111-11111", output: "111-1111-11111")
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertEqual(contactValidityChecker.checkPhoneNumberValidation(phoneNumber.input), phoneNumber.output)
        }
    }
    
    func test_연락처_하이픈이_올바른_위치에_있는지() {
        let phoneNumbers = [
            (input: "--111111111", output: nil),
            (input: "-111111111-", output: nil),
            (input: "111111111--", output: nil),
            (input: "111-111-111", output: "111-111-111"),
            (input: "11111--1111", output: nil),
            (input: "111-1111-1111", output: "111-1111-1111"),
            (input: "111-1111-11111", output: "111-1111-11111")
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertEqual(contactValidityChecker.checkPhoneNumberValidation(phoneNumber.input), phoneNumber.output)
        }
    }
    
    func test_연락처_하이픈_제거하면_숫자만_있는지() {
        let phoneNumbers = [
            (input: "111-111-111", output: "111-111-111"),
            (input: "111-1111-1111", output: "111-1111-1111"),
            (input: "111-1111-111a1", output: nil),
            (input: "aaa-bbb-cccc", output: nil),
            (input: "#222-1111-11111", output: nil)
        ]
        
        for phoneNumber in phoneNumbers {
            XCTAssertEqual(contactValidityChecker.checkPhoneNumberValidation(phoneNumber.input), phoneNumber.output)
        }
    }
}
