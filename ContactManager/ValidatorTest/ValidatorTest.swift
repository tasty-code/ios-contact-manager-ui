//
//  ValidatorTest.swift
//  ValidatorTest
//
//  Created by DONGWOOK SEO on 2023/02/03.
//

import XCTest
@testable import ContactManager

final class ValidatorTest: XCTestCase {
    var sut: Validator!
    
    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_formmatingPhoneNumber메서드가_10자리이상_였을때_잘_작동하는지() {
        let userInput = "12345678901"
        let expectation = "123-456-78901"
        
        let result = sut.formmatingPhoneNumber(with: userInput)
        
        XCTAssertEqual(expectation, result)
    }
    
    func test_formmatingPhoneNumber메서드가_9자리였을때_잘_작동하는지() {
        let userInput = "123456789"
        let expectation = "12-345-6789"
        
        let result = sut.formmatingPhoneNumber(with: userInput)
        
        XCTAssertEqual(expectation, result)
    }
    
    func test_formmatingPhoneNumber메서드가_9자리이하였을때_잘_작동하는지() {
        let userInput = "123456"
        let expectation = "Should be Error"
        
        let result = sut.formmatingPhoneNumber(with: userInput)
        
        XCTAssertEqual(expectation, result)
    }
}
